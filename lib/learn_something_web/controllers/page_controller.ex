defmodule LearnSomethingWeb.PageController do
  use LearnSomethingWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
