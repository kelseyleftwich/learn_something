defmodule LearnSomething.Repo.Migrations.AddLinkModel do
  use Ecto.Migration

  def change do
    create table("links") do
      add :href, :string, null: false
      add :tldr, :string

      timestamps()
    end
  end
end
