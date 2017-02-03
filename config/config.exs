# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

config :reviewcast, sources: [Reviewcast.Fetcher.Source.ITunes]

# General application configuration
config :reviewcast,
  ecto_repos: [Reviewcast.Repo]

config :reviewcast, Reviewcast.Repo,
  adapter: Ecto.Adapters.Postgres,
  url: {:system, "DATABASE_URL"},
  pool_size: 5


# Configures the endpoint
config :reviewcast, Reviewcast.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "94QmIl2YNulxK6DmnoHO56CbvHFLDSBKZXHFGFRFR1tynkTnU9vzn7+PbpJw4oFS",
  render_errors: [view: Reviewcast.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Reviewcast.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
