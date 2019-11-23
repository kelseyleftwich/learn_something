defmodule LearnSomething.Links.Link do
  @moduledoc """
  Schema defining link
  """

  use Ecto.Schema
  import Ecto.Changeset

  schema "links" do
    field :href, :string
    field :tldr, :string

    timestamps()
  end

  def changeset(link, attrs) do
    link
    |> cast(attrs, [:href, :tldr])
    |> validate_required([:href, :tldr])
  end

end
