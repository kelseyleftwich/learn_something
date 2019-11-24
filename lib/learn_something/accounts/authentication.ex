defmodule LearnSomething.Accounts.Authentication do
  use Ecto.Schema
  import Ecto.Changeset

  alias LearnSomething.Accounts.User

  schema "users" do
    field :email, :string
  end

  def changeset(auth, attrs) do
    auth
    |> cast(attrs, [:email])
    |> validate_required([:email])
    |> validate_user()
  end

  defp validate_user(changeset) do
    validate_change(changeset, :email, fn (_current_field, value) ->
      case LearnSomething.Repo.get_by(User, email: value) do
        nil -> [{:email, "Invalid login"}]
        _ -> []
      end
    end)
  end
end
