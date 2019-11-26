defmodule LearnSomething.TagStore do
  @moduledoc """
  Store for tags
  """

  alias LearnSomething.Links.Tag
  alias LearnSomething.Repo

  def list_tags() do
    Repo.all(Tag)
  end
end
