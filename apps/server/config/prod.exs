use Mix.Config

config :logger, level: :info

config :server, Reviewcast.Repo,
  adapter: Ecto.Adapters.Postgres,
  url: {:system, "DATABASE_URL"},
  pool_size: 5
