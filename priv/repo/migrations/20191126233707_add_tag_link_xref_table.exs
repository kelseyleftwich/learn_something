defmodule LearnSomething.Repo.Migrations.AddTagLinkXrefTable do
  use Ecto.Migration

  def change do
    create table(:links_tags, primary_key: false) do
      add :link_id, references(:links, on_delete: :delete_all),
        primary_key: true,
        null: false

      add :tag_id, references(:tags, on_delete: :delete_all),
        primary_key: true,
        null: false
    end

    create unique_index(:links_tags, [:link_id, :tag_id])
  end
end
