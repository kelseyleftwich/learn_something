defmodule LearnSomething.AuthenticationPlug do
  @behaviour Plug
  import Plug.Conn
  import Phoenix.LiveView.Controller
  import Phoenix.Controller

  alias LearnSomething.Router.Helpers, as: Routes

  @impl Plug
  def init(opts) do
    opts
  end

  @impl Plug
  def call(conn, _) do
    with {:ok, id} <- fetch_session_key(conn),
         user <- fetch_user(id) do
      assign(conn, :id, user.id)
    else
      _ -> error(conn)
    end
  end

  def fetch_user(id), do: LearnSomething.UserStore.get_user(id)

  def fetch_session_key(conn) do
    case get_session(conn, :id) do
      nil -> {:error, :not_found}
      id -> {:ok, id}
    end
  end

  defp error(%Plug.Conn{request_path: request_path} = conn) when request_path != "/login" do
    conn
    |> Phoenix.Controller.redirect(to: "/login")
    |> halt()
  end

  defp error(conn) do
    conn
  end
end
