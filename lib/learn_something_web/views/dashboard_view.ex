defmodule LearnSomethingWeb.DashboardView do
  use LearnSomethingWeb, :view

  def color(index) do
    LearnSomethingWeb.Colors.color(index)
  end
end
