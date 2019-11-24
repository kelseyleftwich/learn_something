defmodule LearnSomething.Accounts do
  alias LearnSomething.Accounts.User
  alias LearnSomething.Repo

  def get_user(id) do
    Repo.get(User, id)
  end

  def list_users() do
    Repo.all(User)
  end
end
