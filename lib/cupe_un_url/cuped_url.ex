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
end
