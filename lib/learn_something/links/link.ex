defmodule LearnSomething.Links.Link do
  @moduledoc """
  Schema defining link
  """

  use Ecto.Schema
  import Ecto.Changeset

  schema "links" do
    field :href, :string
    field :title, :string

    belongs_to :user, LearnSomething.Accounts.User

    timestamps()
  end

  def changeset(link, attrs) do
    link
    |> cast(attrs, [:href, :title, :user_id])
    |> validate_required([:href, :title, :user_id])
    |> assoc_constraint(:user)
  end
end
