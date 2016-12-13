use Mix.Config

config :logger, level: :info

config :server, Reviewcast.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: "reviewcast_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
