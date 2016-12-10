use Mix.Config

config :server, Server.PodcastRepo,
  adapter: Ecto.Adapters.Postgres,
  database: "reviewcast",
  hostname: "localhost"
