defmodule LearnSomethingWeb.UserLive.New do
  use Phoenix.LiveView
  alias LearnSomethingWeb.UserView
  alias LearnSomething.Accounts

  def mount(_session, socket) do
    {:ok, assign(socket, changeset: Accounts.User.changeset(%Accounts.User{}, %{}))}
  end

  def render(assigns) do
    UserView.render("new_user.html", assigns)
  end

  def handle_event("add", %{"user" => user}, socket) do
    case LearnSomething.UserStore.create_user(%Accounts.User{}, user) do
      {:ok, _user} ->
        {:noreply, live_redirect(socket, to: "/")}

      {:error, changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
