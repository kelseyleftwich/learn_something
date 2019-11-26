defmodule LearnSomething.TagTest do
  use LearnSomething.DataCase
  alias LearnSomething.Links.Tag
  alias LearnSomething.TagStore

  describe "Tag Test" do
    test "changeset is valid with text and creator_id" do
      user = insert(:user)

      attrs = %{text: "Elixir", creator_id: user.id}

      cs =
        %Tag{}
        |> Tag.changeset(attrs)

      assert cs.valid?
    end

    test "changeset is invalid without text or creator_id" do
      user = insert(:user)

      attrs = %{text: "Elixir"}

      cs =
        %Tag{}
        |> Tag.changeset(attrs)

      refute cs.valid?

      attrs = %{creator_id: user.id}

      cs =
        %Tag{}
        |> Tag.changeset(attrs)

      refute cs.valid?
    end

    test "list_tags/0" do
      tag1 = insert(:tag, text: "Elixir")
      tag2 = insert(:tag, text: "Phoenix")

      tags = TagStore.list_tags()

      ids = Enum.map(tags, fn t -> t.id end)


      assert Enum.member?(ids, tag1.id)
      assert Enum.member?(ids, tag2.id)
    end

  end
end
