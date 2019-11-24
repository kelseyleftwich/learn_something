defmodule LearnSomethingWeb.DashboardLive.Index do
  use Phoenix.LiveView
  alias LearnSomethingWeb.DashboardView
  alias LearnSomething.Links

  alias Phoenix.LiveView.Socket

  def mount(_session, socket) do
    {:ok, fetch(assign(socket, changeset: Links.Link.changeset(%Links.Link{}, %{})))}
  end

  def render(assigns) do
    DashboardView.render("dashboard.html", assigns)
  end

  def handle_event(
        "add",
        %{"link" => link},
        %Socket{assigns: %{links: links}} = socket
      ) do
    case Links.create_link(link) do
      {:ok, link} ->
        {:noreply, assign(socket, links: [link | links])}
      {:error, changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end

  def handle_event("click_card", %{"selected-id" => selected_id}, %Socket{assigns: %{links: links}} = socket) do
    selected = Enum.find(links, fn(link) ->
      "#{link.id}" == selected_id
    end)
    {:noreply, assign(socket, selected: selected)}
  end

  defp fetch(socket) do
    links = Links.list_links()
    assign(socket, [links: links, selected: Enum.at(links,0)])
  end
end
