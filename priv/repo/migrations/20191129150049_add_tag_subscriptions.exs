defmodule LearnSomething.Repo.Migrations.AddTagSubscriptions do
  use Ecto.Migration

  def change do
    create table(:tag_subscriptions) do
      add :tag_id, references(:tags), null: false
      add :user_id, references(:users), null: false

      timestamps()
    end
  end
end
