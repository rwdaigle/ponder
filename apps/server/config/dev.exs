use Mix.Config

config :server, Reviewcast.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: "reviewcast",
  hostname: "localhost"
