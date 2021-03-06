defmodule LearnSomething.LinkTest do
  use LearnSomething.DataCase
  alias LearnSomething.Links.Link
  alias LearnSomething.LinkStore

  describe "link" do
    test "changeset with href and title is valid" do
      user = insert(:user)

      cs =
        %Link{}
        |> Link.changeset(%{href: "http://google.com", title: "A search engine", user_id: user.id})

      assert cs.valid?
    end

    test "changeset without href or title is invalid" do
      cs = %Link{} |> Link.changeset(%{href: "http://google.com"})
      refute cs.valid?

      cs = %Link{} |> Link.changeset(%{title: "A search engine"})
      refute cs.valid?
    end

    test "create link/1" do
      user = insert(:user)

      assert {:ok, _link} =
               LearnSomething.Links.create_link(%{
                 href: "http://",
                 title: "hello",
                 user_id: user.id
               })

      assert {:error, %Ecto.Changeset{}} = LearnSomething.Links.create_link(%{href: "http://"})
    end

    test "list_links/1" do
      link1 = insert(:link, href: "google.com")
      link2 = insert(:link, href: "bing.com")

      links = LinkStore.list_links()

      ids = Enum.map(links, fn l -> l.id end)

      assert Enum.member?(ids, link1.id)
      assert Enum.member?(ids, link2.id)
    end

    test "get_link/1" do
      link = insert(:link)

      assert link = LinkStore.get_link(link.id)
    end

    test "add_tag_to_link/2" do
      link = insert(:link)
      tag1 = insert(:tag)
      # another tag we won't associate with the link
      insert(:tag)

      {:ok, link} = LearnSomething.Links.add_tag_to_link(link, tag1)

      assert_struct_in_list(tag1, link.tags, [:id])

      assert length(link.tags) == 1
    end
  end
end
