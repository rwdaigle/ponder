use Mix.Config

config :logger, level: :info

config :reviewcast, Reviewcast.Repo,
  adapter: Ecto.Adapters.Postgres,
  url: {:system, "DATABASE_URL"},
  pool_size: 6
