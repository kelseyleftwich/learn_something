defmodule LearnSomething.LinkTest do
  use LearnSomething.DataCase
  alias LearnSomething.Links.Link

  describe "link" do
    test "changeset with href and title is valid" do
      user = insert(:user)
      cs = %Link{} |> Link.changeset(%{href: "http://google.com", title: "A search engine", user_id: user.id})

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
      assert {:ok, _link} = LearnSomething.Links.create_link(%{href: "http://", title: "hello", user_id: user.id})
      assert {:error, %Ecto.Changeset{}} = LearnSomething.Links.create_link(%{href: "http://"})
    end

    test "list_links/1" do
      link1 = insert(:link)
      link2 = insert(:link)

      links = LearnSomething.LinkStore.list_links()

      assert Enum.member?(links, link1)
      assert Enum.member?(links, link2)
    end

    test "get_link/1" do
      link = insert(:link)

      assert link = LearnSomething.LinkStore.get_link(link.id)
    end
  end
end
