defmodule LearnSomething.TagStore do
  @moduledoc """
  Store for tags
  """

  alias LearnSomething.Links.Tag
  alias LearnSomething.Repo

  def get(id) do
    Repo.get(Tag, id)
  end

  def create_tag(attrs) do
    %Tag{}
    |> Tag.changeset(attrs)
    |> Repo.insert()
  end

  def list_tags() do
    Repo.all(Tag)
    |> Repo.preload([:links])
  end
end
