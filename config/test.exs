import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :cupe_un_url, CupeUnUrlWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "zZejx9kzfPt9IMYETLlyHgsxYA/OFb/aNyJIKL2CcHwb4lU7VsqLfJ6TyOZLomsr",
  server: false

# In test we don't send emails.
config :cupe_un_url, CupeUnUrl.Mailer, adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
