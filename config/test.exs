use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :reviewcast, Reviewcast.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
# config :logger, level: :warn
config :logger, level: :info

config :fetcher, sources: [Fetcher.Source.Mock]

config :reviewcast, Reviewcast.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: "reviewcast_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# Configure your database
# config :reviewcast, Reviewcast.Repo,
#   adapter: Ecto.Adapters.Postgres,
#   username: "postgres",
#   password: "postgres",
#   database: "reviewcast_test",
#   hostname: "localhost",
#   pool: Ecto.Adapters.SQL.Sandbox
