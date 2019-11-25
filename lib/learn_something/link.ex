defmodule LearnSomething.Links do
  @moduledoc """
  Context for links
  """

  alias LearnSomething.Links.Link

  def create_link(attrs) do
    %Link{}
    |> Link.changeset(attrs)
    |> LearnSomething.Repo.insert()
  end
end
