defmodule LearnSomethingWeb.TagsLive.Show do
  use Phoenix.LiveView
  alias LearnSomethingWeb.TagsView
  alias LearnSomething.Links.Tag

  def mount(session, socket) do
    {:ok, assign(socket, user_id: session.user_id, tag: nil)}
  end

  def render(assigns) do
    TagsView.render("show.html", assigns)
  end

  def handle_params(%{"id" => id}, _uri, socket) do
    id =
      case Integer.parse(id) do
        {id, ""} ->
          id
        _ ->
          nil
      end

    with false <- is_nil(id),
         %Tag{} = tag <- LearnSomething.TagStore.get(id) do
      {:noreply, assign(socket, tag: tag)}
    else
      _ -> {:noreply, socket}
    end
  end

  def sort_tags(tags) do
    tags |> Enum.sort(fn a, b -> a.text < b.text end)
  end
end
