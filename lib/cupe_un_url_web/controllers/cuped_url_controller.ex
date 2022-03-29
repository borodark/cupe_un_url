defmodule CupeUnUrlWeb.CupedUrlController do
  use CupeUnUrlWeb, :controller

  alias CupeUnUrl.{Storage.Riak, CupedUrl}

  @storage Application.compile_env(:cupe_un_url, :storage_module, Riak)

  def new(conn, _params) do
    shorty = CupedUrl.generate() |> IO.inspect
    conn
    |> render("new.html", shorty: shorty, longy: "some valid URL")
  end

  def create(conn, %{"shorty" => shorty, "longy" => longy}) do
    %{"shorty" => shorty, "longy" => longy} |> IO.inspect()
    # TODO validate longy
    case @storage.write(%{shorty: shorty, longy: longy}) do
      {:ok, %CupedUrl{shorty: shorty, longy: longy}} ->
        conn
        |> put_flash(:info, "Cuped url created successfully.")
        |> render("show.html", shorty: shorty, longy: longy)

      # |> redirect(to: Routes.cuped_url_path(conn, :show, cuped_url))

      {:error, riak_errors} ->
        conn
        |> put_flash(:error, "Riak Errors: #{inspect(riak_errors)}")
        |> render("new.html", shorty: shorty, longy: longy)
    end
  end

  def show(conn, %{"shorty" => shorty}) do
    # read(CupedUrl.shorty()) :: {:ok, CupedUrl.t()} | {:error, any()}
    case @storage.read(shorty) do
      {:ok, %{shorty: shorty, longy: longy}} ->
        conn
        |> put_flash(:info, "url found successfully!")
        |> render("show.html", shorty: shorty, longy: longy)

      {:error, riak_errors} ->
        conn
        |> put_flash(:error, "Riak Errors: #{inspect(riak_errors)}")
        |> render("show.html", shorty: shorty)
    end
  end
end
