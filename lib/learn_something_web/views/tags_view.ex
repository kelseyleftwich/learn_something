defmodule LearnSomethingWeb.TagsView do
  use LearnSomethingWeb, :view

  alias LearnSomethingWeb.TagsLive

  def color(index) do
    colors = [
      "bg-red-500",
      "bg-purple-500",
      "bg-blue-500",
      "bg-green-500",
      "bg-yellow-600",
      "bg-indigo-500",
      "bg-orange-500"
    ]

    Enum.at(
      colors,
      rem(
        index + 1,
        length(colors)
      )
    )
  end
end
