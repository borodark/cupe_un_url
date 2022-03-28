defmodule CupeUnUrl.Storage do
  @moduledoc false

  alias CupeUnUrl.CupedUrl

  @callback child_spec() :: :supervisor.child_spec()

  @callback write(CupedUrl.t()) :: :ok | {:error, any()}

  @callback read(CupedUrl.shorty()) :: {:ok, CupedUrl.t()} | {:error, any()}
end
