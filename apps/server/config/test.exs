use Mix.Config

config :logger, level: :info

config :server, Server.PodcastRepo,
  adapter: Ecto.Adapters.Postgres,
  database: "reviewcast_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
