use Mix.Config

config :logger, level: :info

config :fetcher, sources: [Fetcher.Source.Mock]

config :reviewcast, Reviewcast.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: "reviewcast_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
