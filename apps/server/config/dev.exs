use Mix.Config

config :server, ReviewCast.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: "reviewcast",
  hostname: "localhost"
