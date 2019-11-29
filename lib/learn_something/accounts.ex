defmodule LearnSomething.Accounts do
  alias LearnSomething.Accounts.User
  alias LearnSomething.Repo

  def authenticate(%{email: email}) do
    Repo.get_by(User, email: email)
  end

  def subscribe_to_tag(user, tag) do
    case LearnSomething.UserStore.add_tag_to_subscriptions(user, tag) do
      {:ok, user} ->
        user
        |> Repo.preload([:tag_subscriptions])

      {:error, changeset} ->
        {:error, changeset}
    end
  end
end
