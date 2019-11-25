defmodule LearnSomethingWeb.DashboardLive.Index do
  use Phoenix.LiveView
  alias LearnSomethingWeb.DashboardView
  alias LearnSomething.Links

  alias Phoenix.LiveView.Socket

  def mount(session, socket) do
    {:ok,
     fetch(
       assign(socket,
         user_id: session.user_id,
         changeset: Links.Link.changeset(%Links.Link{}, %{}),
         comment_changeset: Links.Comment.changeset(%Links.Comment{}, %{})
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
        {:noreply, assign(socket, links: [link | links])}

      {:error, changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end

  def handle_event(
    "add_comment",
    %{"comment" => comment},
    %Socket{assigns: %{comment_changeset: changeset, user_id: user_id, selected: selected}} = socket
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

  defp fetch(socket) do
    links = LearnSomething.LinkStore.list_links()

    assign(socket, links: links, selected: LearnSomething.LinkStore.get_link(Enum.at(links, 0).id))
  end
end
