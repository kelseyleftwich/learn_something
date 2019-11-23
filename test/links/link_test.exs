defmodule LearnSomething.LinkTest do

  use LearnSomething.DataCase
  alias LearnSomething.Links.Link

  describe "link" do
    test "changeset with href and tldr is valid" do
      cs = %Link{} |> Link.changeset(%{href: "http://google.com", tldr: "A search engine"})

      assert cs.valid?
    end

    test "changeset without href or tldr is invalid" do
      cs = %Link{} |> Link.changeset(%{href: "http://google.com"})
      refute cs.valid?

      cs = %Link{} |> Link.changeset(%{tldr: "A search engine"})
      refute cs.valid?
    end

    test "create link" do
      assert {:ok, _link} = LearnSomething.Links.create_link(%{href: "http://", tldr: "hello"})
      assert {:error, %Ecto.Changeset{}} = LearnSomething.Links.create_link(%{href: "http://"})
    end
  end

end
