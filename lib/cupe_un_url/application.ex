defmodule CupeUnUrl.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  alias CupeUnUrl.Storage.Riak

  @storage Application.compile_env(:cupe_un_url, :storage_module, Riak)

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      CupeUnUrlWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: CupeUnUrl.PubSub},
      # Start the Endpoint (http/https)
      CupeUnUrlWeb.Endpoint,
      # Start a worker by calling: CupeUnUrl.Worker.start_link(arg)
      # {CupeUnUrl.Worker, arg}
      @storage.child_spec()
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: CupeUnUrl.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    CupeUnUrlWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
