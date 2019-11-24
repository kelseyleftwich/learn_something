defmodule LearnSomethingWeb.LoginController do
  use LearnSomethingWeb, :controller
  alias LearnSomething.Accounts.User

  @spec index(Plug.Conn.t(), any) :: Plug.Conn.t()
  def index(conn, _params) do
    render(conn, "index.html")
  end

  @spec login(Plug.Conn.t(), map) :: Plug.Conn.t()
  def login(conn, %{"email" => email}) do
    with %User{} = user <- LearnSomething.Accounts.authenticate(%{email: email}) do
      #IO.inspect(user)
      conn
      |> put_user(user)
      |> redirect(to: "/")
    else
      _ ->
        conn
        |> put_flash(:error, gettext("Wrong password"))
        |> redirect(to: "/login")
    end
  end

  @spec logout(Plug.Conn.t(), any) :: Plug.Conn.t()
  def logout(conn, _) do
    conn
    |> clear_session()
    |> redirect(to: "/login")
  end

  def put_user(conn, %{id: id}), do: put_session(conn, :id, id)
end
