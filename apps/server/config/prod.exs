use Mix.Config

config :server, Server.PodcastRepo,
  adapter: Ecto.Adapters.Postgres,
  url: {:system, "DATABASE_URL"},
  pool_size: 20
