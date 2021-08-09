# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :menucard,
  ecto_repos: [Menucard.Repo]

# Configures the endpoint
config :menucard, MenucardWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "jWNq0xFVLH6uXPxoRHuu+QWtqU+XeUEaOYad+ohloWKRGt+AVk4skSnn/UaeKjkh",
  render_errors: [view: MenucardWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Menucard.PubSub,
  live_view: [signing_salt: "Dx5Q5+dG"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
