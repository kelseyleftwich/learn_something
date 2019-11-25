defmodule LearnSomething.Repo.Migrations.AddUniqueConstraintLink do
  use Ecto.Migration

  def change do
    create index("links", [:href], unique: true, name: "links_href_index")
  end
end
