# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

# General application configuration
config :ex_pusher_lite,
  ecto_repos: [ExPusherLite.Repo]

# Configures the endpoint
config :ex_pusher_lite, ExPusherLite.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "DmSeJwzBQ+RpMjGe4fXZ3BHz/MlUamGsHufEZzVepLpMjAdMywgA6RtE7WoWg7dD",
  render_errors: [view: ExPusherLite.ErrorView, accepts: ~w(html json)],
  pubsub: [name: ExPusherLite.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Configure phoenix generators
config :phoenix, :generators,
  migration: true,
  binary_id: false

config :ex_pusher_lite, :admin_authentication,
  username: "pusher_admin_username",
  password: "pusher_admin_password"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
