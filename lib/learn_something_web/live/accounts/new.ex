defmodule LearnSomethingWeb.UserLive.New do
  use Phoenix.LiveView
  alias LearnSomethingWeb.UserView
  alias LearnSomething.Accounts

  alias Phoenix.LiveView.Socket

  def mount(_session, socket) do
    {:ok, assign(socket, changeset: Accounts.User.changeset(%Accounts.User{}, %{}))}
  end

  def render(assigns) do
    UserView.render("new_user.html", assigns)
  end

  def handle_event("add", %{"user" => user}, %Socket{assigns: %{changeset: changeset}} = socket) do
    case Accounts.create_user(%Accounts.User{}, user) do
      {:ok, user} -> {:noreply, socket}
      {:error, changeset} -> {:noreply, assign(socket, changeset: changeset)}
    end
  end

end
