defmodule LearnSomething.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :email, :string
    field :name, :string

    timestamps()
  end

  def changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :name])
    |> validate_required([:email, :name])
    |> unique_constraint(:email)
    |> validate_length(:name, min: 1, max: 20)
    |> validate_format(:email, ~r/@/)
  end
end
