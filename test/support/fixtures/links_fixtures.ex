defmodule CupeUnUrl.LinksFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `CupeUnUrl.Links` context.
  """

  @doc """
  Generate a cuped_url.
  """
  def cuped_url_fixture(attrs \\ %{}) do
    {:ok, cuped_url} =
      attrs
      |> Enum.into(%{
        longy: "some longy",
        shorty: "some shorty"
      })
      |> CupeUnUrl.Links.create_cuped_url()

    cuped_url
  end
end
