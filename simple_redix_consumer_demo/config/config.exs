# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :simple_redix_consumer_demo,
  ecto_repos: [SimpleRedixConsumerDemo.Repo]

# Configures the endpoint
config :simple_redix_consumer_demo, SimpleRedixConsumerDemoWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "KyFy0gJOBguvS0NZpukx/H+0ebiZT4f3zoKHDVxxPy812yB8UioQ8wbE1bi/kzlY",
  render_errors: [view: SimpleRedixConsumerDemoWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: SimpleRedixConsumerDemo.PubSub,
  live_view: [signing_salt: "I5eHef9I"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
