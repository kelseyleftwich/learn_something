defmodule LearnSomething.Repo.Migrations.AddCommentsTable do
  use Ecto.Migration

  def change do
    create table("comments") do
      add :text, :string, null: false
      add :link_id, references(:links), null: false
      add :user_id, references(:users), null: false

      timestamps()
    end
  end
end
