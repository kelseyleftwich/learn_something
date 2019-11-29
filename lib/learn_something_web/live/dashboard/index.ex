defmodule LearnSomethingWeb.DashboardLive.Index do
  use Phoenix.LiveView
  alias LearnSomethingWeb.DashboardView
  alias LearnSomething.Links

  alias Phoenix.LiveView.Socket

  @topic "links"

  def mount(session, socket) do
    LearnSomethingWeb.Endpoint.subscribe(@topic)

    {:ok,
     fetch(
       assign(socket,
         user_id: session.user_id,
         changeset: Links.Link.changeset(%Links.Link{}, %{}),
         comment_changeset: Links.Comment.changeset(%Links.Comment{}, %{}),
         tags: LearnSomething.TagStore.list_tags(),
         select_tags_open: false,
         modal_open: false,
         tag_changeset: Links.Tag.changeset(%Links.Tag{}, %{}),
         alert_text: nil
       )
     )}
  end

  def render(assigns) do
    DashboardView.render("dashboard.html", assigns)
  end

  def handle_event(
        "add",
        %{"link" => link},
        %Socket{assigns: %{links: links, user_id: user_id}} = socket
      ) do
    attrs = Map.put(link, "user_id", user_id)

    case Links.create_link(attrs) do
      {:ok, link} ->
        link = link |> LearnSomething.Repo.preload([:user])
        LearnSomethingWeb.Endpoint.broadcast_from(self(), @topic, "link_created", link)
        send(self(), link)
        {:noreply, assign(socket, links: [link | links])}

      {:error, changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end

  def handle_event(
    "add_comment",
    %{"comment" => comment},
    %Socket{assigns: %{user_id: user_id, selected: selected}} = socket
  ) do
    attrs =
      comment
      |> Map.put("user_id", user_id)
      |> Map.put("link_id", selected.id)

    case Links.create_comment(attrs) do
      %Links.Comment{} = comment ->
        IO.inspect(comment)
        {:noreply, socket}
      {:error, changeset} ->
        IO.inspect(changeset)
        {:noreply, assign(socket, comment_changeset: changeset)}
    end

  end

  def handle_event(
        "click_card",
        %{"selected-id" => selected_id},
        socket
      ) do
    selected =
      LearnSomething.LinkStore.get_link(selected_id)

    {:noreply, assign(socket, selected: selected)}
  end

  def handle_event("toggle_select_tags", _, %Socket{assigns: %{select_tags_open: select_tags_open}} = socket) do
    {:noreply, assign(socket, select_tags_open: !select_tags_open)}
  end

  def handle_event("add_tag_to_link", %{"tag-id" => tag_id},
  %Socket{assigns: %{selected: selected}} = socket) do
    tag = LearnSomething.TagStore.get(tag_id)

    {:ok, selected} =
      selected
      |> Links.add_tag_to_link(tag)

    {:noreply, assign(socket, selected: selected)}
  end

  def handle_event("toggle-tag-modal", _, %Socket{assigns: %{modal_open: modal_open}} = socket) do
    {:noreply, assign(socket, modal_open: !modal_open)}
  end

  def handle_event(
        "create_tag",
        %{"tag" => tag},
        %Socket{assigns: %{tags: tags, selected: selected, user_id: user_id}} = socket
      ) do
    attrs = Map.put(tag, "creator_id", user_id)

    case LearnSomething.TagStore.create_tag(attrs) do
      {:ok, tag} ->
        {:ok, selected} =
          selected
          |> Links.add_tag_to_link(tag)
        {:noreply, assign(socket, tags: [tag | tags], selected: selected, modal_open: false )}

      {:error, changeset} ->
        {:noreply, assign(socket, tag_changeset: changeset)}
    end
  end

  def handle_info(%LearnSomething.Links.Link{} = link, socket) do
    {:noreply, assign(socket, alert_text: "\"#{link.title}\" added by #{link.user.name}")}
  end

  def handle_info(%Phoenix.Socket.Broadcast{topic: @topic, event: "link_created", payload: link},
  %Socket{assigns: %{links: links}} = socket) do
    {:noreply, assign(socket,links: [link | links], alert_text: "\"#{link.title}\" added by #{link.user.name}")}
  end

  defp fetch(socket) do
    links = LearnSomething.LinkStore.list_links()

    assign(socket, links: links, selected: LearnSomething.LinkStore.get_link(Enum.at(links, 0).id))
  end
end
