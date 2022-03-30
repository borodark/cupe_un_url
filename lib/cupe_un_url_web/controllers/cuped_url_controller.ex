defmodule CupeUnUrlWeb.CupedUrlController do
  use CupeUnUrlWeb, :controller

  alias CupeUnUrl.{Storage.Riak, CupedUrl}
  alias ValidUrl

  @storage Application.compile_env(:cupe_un_url, :storage_module, Riak)

  def get_and_redirect(conn, %{"shorty" => shorty}) do
    case @storage.read(shorty) do
      %{shorty: _shorty, longy: longy} ->
        conn
        |> put_flash(:info, "url found successfully!")
        |> redirect(external: longy)

      {:error, riak_errors} ->
        conn
        |> put_flash(:error, "Riak Errors: #{inspect(riak_errors)}")
        |> render("show.html", shorty: shorty)
    end
  end

  def new(conn, _params) do
    shorty = CupedUrl.generate() |> IO.inspect()

    conn
    |> render("new.html", shorty: shorty)
  end

  def create(conn, %{"shorty" => shorty, "longy" => longy}) do
    %{"shorty" => shorty, "longy" => longy} |> IO.inspect()

    case ValidUrl.validate(longy) do
      true ->
        case @storage.write(%{shorty: shorty, longy: longy}) do
          :ok ->
            conn
            # |> render("show.html", shorty: shorty, longy: longy)
            |> put_flash(:info, "Cuped url created successfully.")
            |> redirect(to: Routes.cuped_url_path(conn, :show, shorty: shorty))

          {:error, riak_errors} ->
            conn
            |> put_flash(:error, "Riak Errors: #{inspect(riak_errors)}")
            |> render("new.html", shorty: shorty, longy: longy)
        end

      false ->
        conn
        |> put_flash(:error, "Invalid URL: #{inspect(longy)}")
        |> render("new.html", shorty: shorty, longy: longy)
    end
  end

  def show(conn, %{"shorty" => shorty}) do
    %{"shorty" => shorty} |> IO.inspect()

    case @storage.read(shorty) do
      %{shorty: shorty, longy: longy} ->
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
