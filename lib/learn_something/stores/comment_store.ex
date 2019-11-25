defmodule LearnSomething.CommentStore do
  alias LearnSomething.Repo
  alias LearnSomething.Links.Comment
  import Ecto.Query

  def create_comment(comment, attrs) do
    comment
    |> Comment.changeset(attrs)
    |> Repo.insert()
  end

  def get_comments_for_link(link) do
    query = from c in Comment, where: c.link_id == ^link.id
    Repo.all(query)
  end
end
