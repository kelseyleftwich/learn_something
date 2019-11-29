defmodule LearnSomething.Repo.Migrations.AddTagTable do
  use Ecto.Migration

  def up do
    create table(:tags) do
      add :text, :string, null: false, size: 40
      add :creator_id, references(:users), null: false
      timestamps()
    end

    create index("tags", [:text], unique: true, name: "tags_text_index")
  end

  def down do
    drop table(:tags)
  end
end
