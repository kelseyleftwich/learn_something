defmodule LearnSomething.AccountsTest do
  use LearnSomething.DataCase
  alias LearnSomething.Accounts.User

  describe "Accounts" do
    test "User changeset is valid with email and name attrs" do
      cs = %User{}
      |> User.changeset(%{email: "bill@bob.com", name: "Bill"})

      assert cs.valid?
    end

    test "User changeset is invalid without email or name attrs" do
      cs = %User{}
      |> User.changeset(%{name: "Bill"})

      refute cs.valid?

      cs = %User{}
      |> User.changeset(%{email: "bill@bob.com"})

      refute cs.valid?
    end

    test "User changeset validates email" do
      assert %Ecto.Changeset{
        errors: [email: {"has invalid format",_}]
      } = %User{}
      |> User.changeset(%{email: "billbob.com", name: "Bill"})
    end
  end
end
