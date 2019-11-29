defmodule LearnSomething.Accounts.TagSubscription do
  use Ecto.Schema

  schema "tag_subscriptions" do
    belongs_to :user, LearnSomething.Accounts.User
    belongs_to :tag, LearnSomething.Links.Tag

    timestamps()
  end
end
