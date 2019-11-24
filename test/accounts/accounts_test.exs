defmodule LearnSomething.AccountsTest do
  use LearnSomething.DataCase
  alias LearnSomething.Accounts.User

  describe "Accounts" do
    test "User changeset is valid with email and name attrs" do
      cs =
        %User{}
        |> User.changeset(%{email: "bill@bob.com", name: "Bill"})

      assert cs.valid?
    end

    test "User changeset is invalid without email or name attrs" do
      cs =
        %User{}
        |> User.changeset(%{name: "Bill"})

      refute cs.valid?

      cs =
        %User{}
        |> User.changeset(%{email: "bill@bob.com"})

      refute cs.valid?
    end

    test "User changeset validates email" do
      assert %Ecto.Changeset{
               errors: [email: {"has invalid format", _}]
             } =
               %User{}
               |> User.changeset(%{email: "billbob.com", name: "Bill"})
    end

    test "list_users/0" do
      user1 = insert(:user, name: "Jane")
      user2 = insert(:user, name: "Jack")

      users = LearnSomething.Accounts.list_users()

      assert Enum.member?(users, user1)
      assert Enum.member?(users, user2)
    end

    test "get_user/1" do
      user1 = insert(:user, name: "Jane")

      retrieved_user = LearnSomething.Accounts.get_user(user1.id)

      assert user1 == retrieved_user
    end

    test "create_user/2" do
      %User{}
      |> LearnSomething.Accounts.create_user(%{name: "Jill", email: "jill@email.com"})
    end
  end
end
