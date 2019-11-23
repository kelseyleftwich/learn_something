# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :learn_something,
  ecto_repos: [LearnSomething.Repo]

# Configures the endpoint
config :learn_something, LearnSomethingWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "7tfx10oGi5v2btMeya9Egy7jRK3zBDYzUVn+DBKXTtLNLPkpYxqDNGbOq1SB+Jnj",
  render_errors: [view: LearnSomethingWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: LearnSomething.PubSub, adapter: Phoenix.PubSub.PG2],
  live_view: [
    signing_salt: "8TGbHFv7XSLCDmDINrTkbg9Tj0PKhNDh"
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
