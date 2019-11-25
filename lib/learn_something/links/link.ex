defmodule LearnSomething.Links.Link do
  @moduledoc """
  Schema defining link
  """

  use Ecto.Schema
  import Ecto.Changeset

  schema "links" do
    field :href, :string, unique: true
    field :title, :string

    belongs_to :user, LearnSomething.Accounts.User
    has_many :comments, LearnSomething.Links.Comment

    timestamps()
  end

  def changeset(link, attrs) do
    link
    |> cast(attrs, [:href, :title, :user_id])
    |> validate_required([:href, :title, :user_id])
    |> assoc_constraint(:user)
    |> unique_constraint(:href, name: "links_href_index")
  end
end
