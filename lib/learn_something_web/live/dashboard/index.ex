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
         changeset: Links.Link.changeset(%Links.Link{}, %{})
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
        "click_card",
        %{"selected-id" => selected_id},
        socket
      ) do
    selected =
      LearnSomething.LinkStore.get_link(selected_id)
      |> IO.inspect()

    {:noreply, assign(socket, selected: selected)}
  end

  defp fetch(socket) do
    links = LearnSomething.LinkStore.list_links()

    assign(socket, links: links, selected: LearnSomething.LinkStore.get_link(Enum.at(links, 0).id))
  end
end
