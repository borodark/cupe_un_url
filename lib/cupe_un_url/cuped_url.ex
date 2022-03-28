defmodule CupeUnUrl.CupedUrl do
  @moduledoc false

  @type t() :: %__MODULE__{
          shorty: String.t(),
          longy: String.t()
        }

  @keys [
    :shorty,
    :longy
  ]

  @enforce_keys @keys
  defstruct @keys

  @hash_id_length Application.get_env(:cupe_un_url, :hash_id_length)

  @doc "Generates a HashId"
  @spec generate() :: String.t()
  def generate do
    @hash_id_length
    |> :crypto.strong_rand_bytes()
    |> Base.encode32(case: :lower)
    |> binary_part(0, @hash_id_length)
  end

  @doc """
  Creates a cuped_url.
  Error out the invalid URLs: no http://, etc 
  ## Examples

  iex> new(valid_url)
  {:ok, %CupedUrl{shorty: "lowercaserandomid" ,longy: valid_url}}

  iex> new(invalid_valid_url)
  {:error, ...}

  """
  def new(long_url) do
    require ValidUrl
    case long_url |> ValidUrl.validate() do
      true -> {:ok, %CupedUrl{shorty: generate(), longy: long_url}}
      _ -> {:error, :invalid_url}
    end
  end
end
