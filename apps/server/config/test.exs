use Mix.Config

config :server, Server.PodcastRepo,
  adapter: Ecto.Adapters.Postgres,
  database: "reviewcast_test",
  hostname: "localhost"
