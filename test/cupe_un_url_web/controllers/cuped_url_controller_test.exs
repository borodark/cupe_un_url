defmodule CupeUnUrlWeb.CupedUrlControllerTest do
  use CupeUnUrlWeb.ConnCase

  import CupeUnUrl.LinksFixtures

  @create_attrs %{longy: "some longy", shorty: "some shorty"}
  @update_attrs %{longy: "some updated longy", shorty: "some updated shorty"}
  @invalid_attrs %{longy: nil, shorty: nil}

  describe "index" do
    test "lists all links", %{conn: conn} do
      conn = get(conn, Routes.cuped_url_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Links"
    end
  end

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

  describe "edit cuped_url" do
    setup [:create_cuped_url]

    test "renders form for editing chosen cuped_url", %{conn: conn, cuped_url: cuped_url} do
      conn = get(conn, Routes.cuped_url_path(conn, :edit, cuped_url))
      assert html_response(conn, 200) =~ "Edit Cuped url"
    end
  end

  describe "update cuped_url" do
    setup [:create_cuped_url]

    test "redirects when data is valid", %{conn: conn, cuped_url: cuped_url} do
      conn = put(conn, Routes.cuped_url_path(conn, :update, cuped_url), cuped_url: @update_attrs)
      assert redirected_to(conn) == Routes.cuped_url_path(conn, :show, cuped_url)

      conn = get(conn, Routes.cuped_url_path(conn, :show, cuped_url))
      assert html_response(conn, 200) =~ "some updated longy"
    end

    test "renders errors when data is invalid", %{conn: conn, cuped_url: cuped_url} do
      conn = put(conn, Routes.cuped_url_path(conn, :update, cuped_url), cuped_url: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Cuped url"
    end
  end

  describe "delete cuped_url" do
    setup [:create_cuped_url]

    test "deletes chosen cuped_url", %{conn: conn, cuped_url: cuped_url} do
      conn = delete(conn, Routes.cuped_url_path(conn, :delete, cuped_url))
      assert redirected_to(conn) == Routes.cuped_url_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.cuped_url_path(conn, :show, cuped_url))
      end
    end
  end

  defp create_cuped_url(_) do
    cuped_url = cuped_url_fixture()
    %{cuped_url: cuped_url}
  end
end
