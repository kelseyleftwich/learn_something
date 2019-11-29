defmodule LearnSomething.LinkStore do
  alias LearnSomething.Repo
  alias LearnSomething.Links.Link
  import Ecto.Query

  def get_link(id) do
    Repo.get(LearnSomething.Links.Link, id)
    |> Repo.preload([:user, :tags, comments: [:user]])
  end

  def list_links() do
    query = from l in Link, order_by: [desc: l.inserted_at]

    Repo.all(query)
    |> Repo.preload([:user, :tags, comments: [:user]])
  end

  def create_link(attrs) do
    %Link{}
    |> Link.changeset(attrs)
    |> LearnSomething.Repo.insert()
  end

  def add_tag_to_link(link, tag) do
    link
    |> Link.add_tag_changeset(tag)
    |> LearnSomething.Repo.update()
  end

  def get_by_tag(tag_id) do
    query =
      from l in Link,
        join: lt in "links_tags",
        on: l.id == lt.link_id,
        where: lt.tag_id == ^tag_id

    Repo.all(query)
    |> Repo.preload([:user, :tags, comments: [:user]])
  end
end
