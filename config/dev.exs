use Mix.Config

config :logger, level: :info

config :server, Reviewcast.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: "reviewcast",
  hostname: "localhost",
  pool_size: 3
