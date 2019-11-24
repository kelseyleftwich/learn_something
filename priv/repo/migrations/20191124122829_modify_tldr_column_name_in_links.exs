defmodule LearnSomething.Repo.Migrations.ModifyTldrColumnNameInLinks do
  use Ecto.Migration

  def up do
    rename table(:links), :tldr, to: :title
  end

  def down do
    rename table(:links), :title, to: :tldr
  end
end
