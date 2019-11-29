defmodule LearnSomethingWeb.TagsLive.Index do
  use Phoenix.LiveView
  alias LearnSomethingWeb.TagsView
  alias Phoenix.LiveView.Socket

  def mount(session, socket) do
    tags =
      LearnSomething.TagStore.list_tags() |> sort_tags()
      |> Enum.map(fn tag -> add_subscribed_field(tag, session.user_id) end)

    {:ok, assign(socket, user_id: session.user_id, tags: tags)}
  end

  def render(assigns) do
    TagsView.render("tags.html", assigns)
  end

  def sort_tags(tags) do
    tags |> Enum.sort(fn a, b -> a.text < b.text end)
  end

  def handle_event(
        "subscribe_to_tag",
        %{"tag-id" => tag_id},
        %Socket{assigns: %{user_id: user_id, tags: tags}} = socket
      ) do
    case LearnSomething.Accounts.subscribe_to_tag(user_id, tag_id) do
      %LearnSomething.Accounts.User{} ->
        tags =
          tags
          |> Enum.map(fn tag -> add_subscribed_field(tag, user_id) end)
        {:noreply, assign(socket, tags: tags)}
      _ ->
        {:noreply, socket}
    end
  end

  def handle_event(
        "unsubscribe_from_tag",
        %{"tag-id" => tag_id},
        %Socket{assigns: %{user_id: user_id, tags: tags}} = socket
      ) do
    case LearnSomething.Accounts.unsubscribe_from_tag(user_id, tag_id) do
      %LearnSomething.Accounts.User{} ->
        tags =
          tags
          |> Enum.map(fn tag -> add_subscribed_field(tag, user_id) end)
        {:noreply, assign(socket, tags: tags)}
      _ ->
        {:noreply, socket}
    end
  end

  defp add_subscribed_field(tag, user_id) do
    Map.put(
      tag,
      :subscribed,
      LearnSomething.Accounts.subscribed_to_tag?(user_id, tag.id)
    )
  end
end
