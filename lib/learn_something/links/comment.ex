defmodule LearnSomething.Links.Comment do
  @moduledoc """
  Schema defining comment
  """

  use Ecto.Schema
  import Ecto.Changeset

  schema "comments" do
    field :text, :string, null: false

    belongs_to :user, LearnSomething.Accounts.User
    belongs_to :link, LearnSomething.Links.Link

    timestamps()
  end

  def changeset(comment, attrs) do
    comment
    |> cast(attrs, [:text, :user_id, :link_id])
    |> validate_required([:text, :user_id, :link_id])
    |> assoc_constraint(:user)
    |> assoc_constraint(:link)
  end
end
