defmodule LearnSomethingWeb.UserLive.Login do
  use Phoenix.LiveView
  alias LearnSomethingWeb.UserView
  alias LearnSomething.Accounts
  alias LearnSomething.Accounts.Authentication

  alias Phoenix.LiveView.Socket

  def mount(_session, socket) do
    {:ok, assign(socket, changeset: Authentication.changeset(%Authentication{}, %{}))}
  end

  def render(assigns) do
    UserView.render("login.html", assigns)
  end

  def handle_event(
        "authenticate",
        _,
        %Socket{assigns: %{changeset: changeset}} = socket
      ) do
    %Ecto.Changeset{} = changeset

    case Accounts.authenticate(changeset) do
      %Accounts.User{} = user ->
        {:noreply, live_redirect(assign(socket, user_id: user.id), to: "/")}

      changeset ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
