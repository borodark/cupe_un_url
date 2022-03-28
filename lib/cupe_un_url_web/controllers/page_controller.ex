defmodule CupeUnUrlWeb.PageController do
  use CupeUnUrlWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
