defmodule LearnSomethingWeb.PageControllerTest do
  use LearnSomethingWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Learn Something"
  end
end
