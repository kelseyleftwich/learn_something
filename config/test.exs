use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :learn_something, LearnSomethingWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :learn_something, LearnSomething.Repo,
  username: "postgres",
  password: "postgres",
  database: "learn_something_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
