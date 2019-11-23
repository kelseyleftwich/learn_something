defmodule LearnSomething.Repo do
  use Ecto.Repo,
    otp_app: :learn_something,
    adapter: Ecto.Adapters.Postgres
end
