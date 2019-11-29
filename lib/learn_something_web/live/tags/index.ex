defmodule LearnSomethingWeb.TagsLive.Index do
  use Phoenix.LiveView
  alias LearnSomethingWeb.TagsView

  alias Phoenix.LiveView.Socket

  def mount(session, socket) do
    tags = LearnSomething.TagStore.list_tags() |> sort_tags()
    {:ok, assign(socket, user_id: session.user_id, tags: tags)}
  end

  def render(assigns) do
    TagsView.render("tags.html", assigns)
  end

  def sort_tags(tags) do
    tags |> Enum.sort(fn a, b -> a.text < b.text end)
  end
end
