defmodule LearnSomething.Accounts do
  alias LearnSomething.Accounts.User
  alias LearnSomething.Repo

  @spec authenticate(%{email: String.t()}) :: User.t() | nil
  def authenticate(%{email: email}) do
    Repo.get_by(User, email: email)
  end

  def unsubscribe_from_tag(user_id, tag_id) do
    IO.inspect("hello")
    user = LearnSomething.UserStore.get_user(user_id)
    tag = LearnSomething.TagStore.get(tag_id)

    case LearnSomething.UserStore.remove_tag_from_subscriptions(user, tag) do
      {:ok, user} ->
        user
        |> Repo.preload([:tag_subscriptions])

      {:error, changeset} ->
        {:error, changeset}
    end
  end

  def subscribe_to_tag(user_id, tag_id) do
    user = LearnSomething.UserStore.get_user(user_id)
    tag = LearnSomething.TagStore.get(tag_id)

    case LearnSomething.UserStore.add_tag_to_subscriptions(user, tag) do
      {:ok, user} ->
        user
        |> Repo.preload([:tag_subscriptions])

      {:error, changeset} ->
        {:error, changeset}
    end
  end

  @spec subscribed_to_tag?(any, any) :: boolean
  def subscribed_to_tag?(user_id, tag_id) do
    user = LearnSomething.UserStore.get_user(user_id)
    subscribed_tag_ids = Enum.map(user.tag_subscriptions, fn tag -> tag.id end)

    Enum.member?(subscribed_tag_ids, tag_id)
  end
end
