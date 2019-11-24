defmodule LearnSomething.Repo.Migrations.AddUserLinkRelation do
  use Ecto.Migration
  import Ecto.Query

  def up do
    alter table(:links) do
      add :user_id, references(:users)
    end

    flush()

    query =
      from(user in "users",
      where: user.email == "kelsey.leftwich@gmail.com",
      select: user.id
    )

    user_id = LearnSomething.Repo.one(query)

    query =
      from(link in "links",
        where: is_nil(link.user_id),
        update: [set: [user_id: ^user_id]]
      )

    LearnSomething.Repo.update_all(query, [])

    flush()

    drop constraint("links", "links_user_id_fkey")

    alter table(:links) do
      modify :user_id, references(:users), null: false
    end
  end

  def down do
    alter table(:links) do
      remove :user_id
    end
  end
end
