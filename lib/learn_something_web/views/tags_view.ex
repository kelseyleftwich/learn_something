defmodule LearnSomethingWeb.TagsView do
  use LearnSomethingWeb, :view

  def color(index) do
    LearnSomethingWeb.Colors.color(index)
  end
end
