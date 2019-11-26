defmodule LearnSomething.CommentTest do
  use LearnSomething.DataCase
  alias LearnSomething.Links.Comment
  alias LearnSomething.CommentStore

  describe "Comments" do
    test "changeset is valid with text, link, and user" do
      user = insert(:user)
      link = insert(:link)

      cs = %Comment{} |> Comment.changeset(%{text: "Cool!", user_id: user.id, link_id: link.id})

      assert cs.valid?
    end

    test "changeset is invalid without text" do
      user = insert(:user)
      link = insert(:link)

      cs = %Comment{} |> Comment.changeset(%{user_id: user.id, link_id: link.id})

      refute cs.valid?
    end

    test "changeset is invalid without user" do
      link = insert(:link)

      cs = %Comment{} |> Comment.changeset(%{text: "Cool!", link_id: link.id})

      refute cs.valid?
    end

    test "changeset is invalid without link" do
      user = insert(:user)

      cs = %Comment{} |> Comment.changeset(%{text: "Cool!", user_id: user.id})

      refute cs.valid?
    end

    test "create_changeset/1" do
      user = insert(:user)
      link = insert(:link)

      CommentStore.create_comment(%{text: "Cool!", user_id: user.id, link_id: link.id})
    end

    test "get_comments_for_link" do
      link = insert(:link)
      comment1 = insert(:comment, link: link)
      comment2 = insert(:comment, link: link)

      comments = CommentStore.get_comments_for_link(link)

      ids = Enum.map(comments, fn c -> c.id end)

      assert Enum.member?(ids, comment1.id)
      assert Enum.member?(ids, comment2.id)
    end
  end

end
