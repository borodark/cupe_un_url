defmodule CupeUnUrlWeb.CupedUrlControllerTest do
  use CupeUnUrlWeb.ConnCase

  import CupeUnUrl.LinksFixtures

  @create_attrs %{longy: "some longy", shorty: "some shorty"}
  @invalid_attrs %{longy: nil, shorty: nil}

  describe "new cuped_url" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.cuped_url_path(conn, :new))
      assert html_response(conn, 200) =~ "New Cuped url"
    end
  end

  describe "create cuped_url" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.cuped_url_path(conn, :create), cuped_url: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.cuped_url_path(conn, :show, id)

      conn = get(conn, Routes.cuped_url_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Cuped url"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.cuped_url_path(conn, :create), cuped_url: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Cuped url"
    end
  end

  defp create_cuped_url(_) do
    cuped_url = cuped_url_fixture()
    %{cuped_url: cuped_url}
  end
end
