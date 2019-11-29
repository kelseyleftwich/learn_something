defmodule LearnSomething.UserStore do
  alias LearnSomething.Repo
  alias LearnSomething.Accounts.User

  def get_user(id) do
    Repo.get(User, id)
    |> Repo.preload([:tag_subscriptions])
  end

  def list_users() do
    Repo.all(User)
  end

  def create_user(user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  def add_tag_to_subscriptions(user, tag) do
    user
    |> User.add_tag_subscription_changeset(tag)
    |> LearnSomething.Repo.update()
  end

  def remove_tag_from_subscriptions(user, tag) do
    user
    |> User.remove_tag_subscription_changeset(tag)
    |> LearnSomething.Repo.update()
  end
end
