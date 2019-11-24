defmodule LearnSomething.LinkTest do

  use LearnSomething.DataCase
  alias LearnSomething.Links.Link

  describe "link" do
    test "changeset with href and title is valid" do
      cs = %Link{} |> Link.changeset(%{href: "http://google.com", title: "A search engine"})

      assert cs.valid?
    end

    test "changeset without href or title is invalid" do
      cs = %Link{} |> Link.changeset(%{href: "http://google.com"})
      refute cs.valid?

      cs = %Link{} |> Link.changeset(%{title: "A search engine"})
      refute cs.valid?
    end

    test "create link" do
      assert {:ok, _link} = LearnSomething.Links.create_link(%{href: "http://", title: "hello"})
      assert {:error, %Ecto.Changeset{}} = LearnSomething.Links.create_link(%{href: "http://"})
    end
  end

end
