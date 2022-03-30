defmodule CupeUnUrlWeb.CupedUrlControllerTest do
  use CupeUnUrlWeb.ConnCase

  @create_attrs longy:
                  "https://www.google.com/search?q=url+shortener&oq=google+u&aqs=chrome.0.69i59j69i60l3j0j69i57.1069j0j7&sourceid=chrome&ie=UTF-8",
                shorty: "1111"
  @invalid_attrs shorty: "2222", longy: "not realy a URL"

  describe "new " do
    test "renders new form", %{conn: conn} do
      conn = get(conn, Routes.cuped_url_path(conn, :new))
      assert html_response(conn, 200) =~ "Get Shorty of the url"
    end
  end

  describe "created" do
    test "redirects to show both shorty and lonly", %{conn: conn} do
      conn = post(conn, Routes.cuped_url_path(conn, :create), @create_attrs)
      assert redirected_to(conn) == Routes.cuped_url_path(conn, :show, shorty: 1111)
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.cuped_url_path(conn, :create), @invalid_attrs)
      assert html_response(conn, 200) =~ "Invalid URL:"
    end
  end
end
