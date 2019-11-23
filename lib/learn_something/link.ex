defmodule LearnSomething.Links do
  @moduledoc """
  Context for links
  """

  alias LearnSomething.Links.Link

  def list_links() do
    LearnSomething.Repo.all(Link)
  end

  def create_link(attrs) do
    %Link{}
    |> Link.changeset(attrs)
    |> LearnSomething.Repo.insert()
  end
end
