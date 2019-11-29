defmodule LearnSomethingWeb.DashboardLive.Index do
  use Phoenix.LiveView
  alias LearnSomethingWeb.DashboardView
  alias LearnSomething.Links

  alias Phoenix.LiveView.Socket

  @topic "links"

  def mount(session, socket) do
    LearnSomethingWeb.Endpoint.subscribe(@topic)

    {:ok,

       assign(socket,
         user_id: session.user_id,
         user: LearnSomething.UserStore.get_user(session.user_id),
         alert: %{message: nil, link: nil}
       )
     }
  end

  def render(assigns) do
    DashboardView.render("dashboard.html", assigns)
  end

  def handle_info(
        %Phoenix.Socket.Broadcast{topic: @topic, event: "link_created", payload: link},
        socket
      ) do
    {:noreply,
     assign(socket,
       alert: %{message: "\"#{link.title}\" added by #{link.user.name}", link: link}
     )}
  end

  def handle_event("dismiss_alert", _, socket) do
    {:noreply, assign(socket, alert: %{message: nil, link: nil})}
  end

end
