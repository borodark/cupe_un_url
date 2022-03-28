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
  @spec generate() :: String.t
  def generate do
    @hash_id_length
    |> :crypto.strong_rand_bytes()
    |> Base.encode32(case: :lower)
    |> binary_part(0, @hash_id_length)
  end

end
