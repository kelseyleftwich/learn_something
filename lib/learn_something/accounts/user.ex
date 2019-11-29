defmodule LearnSomething.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias LearnSomething.Links.Tag

  schema "users" do
    field :email, :string
    field :name, :string

    many_to_many(:tag_subscriptions, LearnSomething.Links.Tag,
      join_through: LearnSomething.Accounts.TagSubscription, on_replace: :delete)

    has_many(:links, LearnSomething.Links.Link)

    timestamps()
  end

  def changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :name])
    |> validate_required([:email, :name])
    |> unique_constraint(:email)
    |> validate_length(:name, min: 1, max: 20)
    |> validate_format(:email, ~r/@/)
  end

  def add_tag_subscription_changeset(user, %Tag{} = tag) do
    user
    |> Ecto.Changeset.change()
    |> put_assoc(:tag_subscriptions, [tag | user.tag_subscriptions])
    |> unique_tag_subscriptions_constraint(user, tag)
  end

  def remove_tag_subscription_changeset(user, %Tag{} = tag) do
    filtered_tags =
      user.tag_subscriptions
      |> Enum.filter(fn t -> t.id != tag.id end)

    user
    |> Ecto.Changeset.change()
    |> put_assoc(:tag_subscriptions, filtered_tags)
  end

  def unique_tag_subscriptions_constraint(changeset, user, tag) do
    subscription_tag_ids = Enum.map(user.tag_subscriptions, fn t -> t.id end)

    case Enum.member?(subscription_tag_ids, tag.id) do
      true ->
        changeset
        |> add_error(:tag_subscriptions, "already subscribed to tag")

      false ->
        changeset
    end
  end
end
