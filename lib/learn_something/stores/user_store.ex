defmodule LearnSomething.UserStore do
  alias LearnSomething.Repo
  alias LearnSomething.Accounts.User

  def get_user(id) do
    Repo.get(User, id)
  end

  def list_users() do
    Repo.all(User)
  end

  def create_user(user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.insert()
  end
end
