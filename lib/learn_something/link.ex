defmodule LearnSomething.Links do
  @moduledoc """
  Context for links
  """

  def create_link(attrs) do
    LearnSomething.LinkStore.create_link(attrs)
  end

  def create_comment(changeset) do
    LearnSomething.CommentStore.create_comment(changeset)
  end
end
