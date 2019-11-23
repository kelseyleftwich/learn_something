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

  defp fetch(socket) do
    assign(socket, links: Links.list_links())
  end
end
