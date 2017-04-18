# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :quill,
  ecto_repos: [Quill.Repo]

# Configures the endpoint
config :quill, Quill.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "H03DT+knFIKoEzEGUrqSse2i8iOKFTe5OCKiJ5l84WF62pRVFYysYQx1U3Rvo362",
  render_errors: [view: Quill.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Quill.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
