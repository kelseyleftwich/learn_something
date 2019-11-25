defmodule LearnSomething.LinkStore do
  alias LearnSomething.Repo
  alias LearnSomething.Links.Link
  import Ecto.Query

  def get_link(id) do


    Repo.get(LearnSomething.Links.Link, id)

    |> Repo.preload([:user])
  end

  def list_links() do
    query = from l in Link, order_by: [desc: l.inserted_at]

    Repo.all(query)
    |> Repo.preload([:user])

  end
end
