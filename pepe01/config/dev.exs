use Mix.Config

# For development, we disable any cache and enable
# debugging and code reloading.
#
# The watchers configuration can be used to run external
# watchers to your application. For example, we use it
# with brunch.io to recompile .js and .css sources.
config :pepe01, Pepe01.Endpoint,
  http: [port: 8080],
  debug_errors: true,
  code_reloader: true,
  check_origin: false,
  watchers: [node: ["node_modules/brunch/bin/brunch", "watch", "--stdin"]]

# Watch static and templates for browser reloading.
config :pepe01, Pepe01.Endpoint,
  live_reload: [
    patterns: [
      ~r{priv/static/.*(js|css|png|jpeg|jpg|gif|svg)$},
      ~r{priv/gettext/.*(po)$},
      ~r{web/views/.*(ex)$},
      ~r{web/templates/.*(eex)$}
    ]
  ]

# Do not include metadata nor timestamps in development logs
config :logger, :console, format: "[$level] $message\n"

# Set a higher stacktrace during development.
# Do not configure such in production as keeping
# and calculating stacktraces is usually expensive.
config :phoenix, :stacktrace_depth, 20

# Configure your database
config :pepe01, Pepe01.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "pepe01_dev",
  hostname: "localhost",
  template: "template0",
  pool_size: 10

# Openmaize authentication library configuration
# For more information about configuration, see the documentation
# for the Openmaize.Config module.
config :openmaize,
  user_model: Pepe01.User,
  repo: Pepe01.Repo

# Configure mailgunsource
config :pepe01,
  mailgun_domain: String.rstrip(System.get_env("mailgun_API_Base_URL")),
  mailgun_key:    String.rstrip(System.get_env("mailgun_API_Key")),
  confirmation_url: "TBD"
