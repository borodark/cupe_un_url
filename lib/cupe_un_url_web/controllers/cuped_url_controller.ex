defmodule CupeUnUrlWeb.CupedUrlController do
  use CupeUnUrlWeb, :controller

  alias CupeUnUrl.{Storage.Riak, CupedUrl}

  @storage Application.compile_env(:cupe_un_url, :storage_module, Riak)

  # as per req -> render new
  def index(conn, params) do
    new(conn, params)
  end

  def new(conn, _params) do
    changeset = CupedUrl.new
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"cuped_url" => cuped_url_params}) do
    case Links.create_cuped_url(cuped_url_params) do
      {:ok, cuped_url} ->
        conn
        |> put_flash(:info, "Cuped url created successfully.")
        |> redirect(to: Routes.cuped_url_path(conn, :show, cuped_url))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    cuped_url = Links.get_cuped_url!(id)
    render(conn, "show.html", cuped_url: cuped_url)
  end
end
