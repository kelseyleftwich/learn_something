defmodule LearnSomethingWeb.DashboardView do
  use LearnSomethingWeb, :view

  def links_added_within_7_days(links) do
    seven_days_ago = Date.add(Date.utc_today(), -7)

    Enum.filter(links, fn l ->
      Date.compare(l.inserted_at, seven_days_ago) == :gt
    end)
  end

  def color(index) do
    LearnSomethingWeb.Colors.color(index)
  end
end
