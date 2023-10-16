# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :restr,
  ecto_repos: [Restr.Repo],
  generators: [binary_id: true]

# Configures the endpoint
config :restr, RestrWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "P6jtw8zidh4zZAR57Dmg7k7uK6qDkqy0IXgv/wSB0ykbBgdFPBX+sFGgB6mASji3",
  render_errors: [view: RestrWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: Restr.PubSub,
  live_view: [signing_salt: "m5KW3x0N"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
