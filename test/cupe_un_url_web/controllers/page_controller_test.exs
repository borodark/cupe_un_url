defmodule CupeUnUrlWeb.PageControllerTest do
  use CupeUnUrlWeb.ConnCase

  test "GET /oldindex", %{conn: conn} do
    conn = get(conn, "/oldindex")
    assert html_response(conn, 200) =~ "Welcome to Phoenix!"
  end
end
