defmodule CupeUnUrl.LinksTest do
  use CupeUnUrl.DataCase

  alias CupeUnUrl.Links

  describe "links" do
    alias CupeUnUrl.Links.CupedUrl

    import CupeUnUrl.LinksFixtures

    @invalid_attrs %{longy: nil, shorty: nil}

    test "list_links/0 returns all links" do
      cuped_url = cuped_url_fixture()
      assert Links.list_links() == [cuped_url]
    end

    test "get_cuped_url!/1 returns the cuped_url with given id" do
      cuped_url = cuped_url_fixture()
      assert Links.get_cuped_url!(cuped_url.id) == cuped_url
    end

    test "create_cuped_url/1 with valid data creates a cuped_url" do
      valid_attrs = %{longy: "some longy", shorty: "some shorty"}

      assert {:ok, %CupedUrl{} = cuped_url} = Links.create_cuped_url(valid_attrs)
      assert cuped_url.longy == "some longy"
      assert cuped_url.shorty == "some shorty"
    end

    test "create_cuped_url/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Links.create_cuped_url(@invalid_attrs)
    end

    test "update_cuped_url/2 with valid data updates the cuped_url" do
      cuped_url = cuped_url_fixture()
      update_attrs = %{longy: "some updated longy", shorty: "some updated shorty"}

      assert {:ok, %CupedUrl{} = cuped_url} = Links.update_cuped_url(cuped_url, update_attrs)
      assert cuped_url.longy == "some updated longy"
      assert cuped_url.shorty == "some updated shorty"
    end

    test "update_cuped_url/2 with invalid data returns error changeset" do
      cuped_url = cuped_url_fixture()
      assert {:error, %Ecto.Changeset{}} = Links.update_cuped_url(cuped_url, @invalid_attrs)
      assert cuped_url == Links.get_cuped_url!(cuped_url.id)
    end

    test "delete_cuped_url/1 deletes the cuped_url" do
      cuped_url = cuped_url_fixture()
      assert {:ok, %CupedUrl{}} = Links.delete_cuped_url(cuped_url)
      assert_raise Ecto.NoResultsError, fn -> Links.get_cuped_url!(cuped_url.id) end
    end

    test "change_cuped_url/1 returns a cuped_url changeset" do
      cuped_url = cuped_url_fixture()
      assert %Ecto.Changeset{} = Links.change_cuped_url(cuped_url)
    end
  end
end
