defmodule LearnSomething.Links.Tag do
  @moduledoc """
  Schema defining tag
  """

  use Ecto.Schema
  import Ecto.Changeset

  schema "tags" do
    field :text, :string, null: false

    belongs_to :creator, LearnSomething.Accounts.User

    many_to_many(:links, LearnSomething.Links.Link, join_through: "links_tags")

    timestamps()
  end

  def changeset(tag, attrs) do
    tag
    |> cast(attrs, [:text, :creator_id])
    |> validate_required([:text, :creator_id])
  end
end
