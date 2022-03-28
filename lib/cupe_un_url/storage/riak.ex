defmodule CupeUnUrl.Storage.Riak do
  @moduledoc false

  alias CupeUnUrl.{CupedUrl, Storage}

  @behaviour Storage

  require Logger

  @bucket "shorties"
  @riak_basic_options [keepalive: true, auto_reconnect: true]

  @impl Storage
  @spec child_spec ::
          {any, {:poolboy, :start_link, [...]}, :permanent, 5000, :worker, [:poolboy, ...]}
  def child_spec do
    worker_arguments = riak_worker_arguments()
    {pool_name, size_arguments} = Application.get_env(:cupe_un_url, :pool_config)

    pool_arguments =
      [
        {:name, {:local, pool_name}},
        {:worker_module, __MODULE__}
      ] ++ size_arguments

    :poolboy.child_spec(pool_name, pool_arguments, worker_arguments)
  end

  #########################################################
  #
  #  Poolboy worker API
  #
  #########################################################

  def start_link(args) do
    ip = Keyword.get(args, :ip)
    port = Keyword.get(args, :port)
    options = Keyword.get(args, :options)

    with {:ok, pid} <- :riakc_pb_socket.start_link(ip, port, options),
         do: {:ok, pid}
  end

  #########################################################
  #
  #  Storage API
  #
  # 
  #########################################################
  @impl Storage
  @spec write(CupedUrl.t()) :: :ok | {:error, any()}

  def write(cuped_url) do
    fn pid ->
      write(pid, cuped_url.shorty, cuped_url.longy)
    end
    |> execute()

    # TODO return :ok
  end

  @impl Storage
  @spec read(CupedUrl.shorty()) :: {:ok, CupedUrl.t()} | {:error, any()}
  def read(shorty) do
    Logger.info("read #{inspect(shorty)}")

    res =
      fn pid ->
        read(pid, shorty)
      end
      |> execute()

    Logger.info("read after #{inspect(res)}")
    res
    # TODO return CupedUrl.t()
  end

  defp read(pid, shorty) do
    case get_object(pid, @bucket, shorty) do
      {:error, :not_found} ->
        {:ok, []}

      {:ok, longy} ->
        %CupedUrl{shorty: shorty, longy: longy}
    end
  end

  defp execute(function) do
    case :poolboy.checkout(:riak_pool, _block = true) do
      :full ->
        {:error, :full}

      pid ->
        try do
          function.(pid)
        after
          :poolboy.checkin(:riak_pool, pid)
          {:error, :poolboy_error}
        end
    end
  end

  defp get_object(pid, bucket, key) do
    case :riakc_pb_socket.get(pid, bucket, key) do
      {:ok, {:riakc_obj, _, _, _, [{_, obj}], _, _}} ->
        Logger.debug("Successfuly got object from #{inspect(bucket)} by key = #{inspect(key)}")
        {:ok, :erlang.binary_to_term(obj)}

      _ ->
        {:error, :not_found}
    end
  end

  defp write(pid, shorty, longy) do
    value = :erlang.term_to_binary(longy)
    obj = :riakc_obj.new(@bucket, shorty, value)
    :riakc_pb_socket.put(pid, obj)
  end
   

  defp riak_worker_arguments do
    {ip_or_env, port_or_env} = Application.get_env(:cupe_un_url, :riak_conn_opts, {"127.0.0.1", 8087})

    ip =
      ip_or_env
      |> read_environment_variable("127.0.0.1")
      |> to_charlist()

    port =
      port_or_env
      |> read_environment_variable("8087")
      |> to_integer()

    [ip: ip, port: port, options: @riak_basic_options]
  end

  defp to_integer(value) when is_integer(value), do: value

  defp to_integer(value) do
    {integer_value, _} = Integer.parse(value)
    integer_value
  end

  defp read_environment_variable({:system, variable}, default),
    do: System.get_env(variable, default)

  defp read_environment_variable(value, _default), do: value
end
