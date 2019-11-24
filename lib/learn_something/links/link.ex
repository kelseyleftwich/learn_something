defmodule LearnSomething.Links.Link do
  @moduledoc """
  Schema defining link
  """

  use Ecto.Schema
  import Ecto.Changeset

  schema "links" do
    field :href, :string
    field :title, :string

    timestamps()
  end

  def changeset(link, attrs) do
    link
    |> cast(attrs, [:href, :title])
    |> validate_required([:href, :title])
  end

end
