# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

# Configures the endpoint
config :repo_two_with_phx, RepoTwoWithPhxWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "MyencVddhyZ9OOPWb584hCx2DcKk3q6VC+Ig0vN1RgZikC7BxCHo23m4ztv/vFX+",
  render_errors: [view: RepoTwoWithPhxWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: RepoTwoWithPhx.PubSub,
  live_view: [signing_salt: "xNBMgAIy"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
