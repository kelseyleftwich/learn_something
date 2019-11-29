defmodule LearnSomething.Repo.Migrations.AddTagSubscriptions do
  use Ecto.Migration

  def change do
    create table(:tag_subscriptions) do
      add :tag_id, references(:tags), null: false
      add :user_id, references(:users), null: false

      timestamps()
    end

    create index("tag_subscriptions", [:tag_id, :user_id], unique: true, name: "sub_tags_id_user_id_index")

  end
end
