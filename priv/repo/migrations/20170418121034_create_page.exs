defmodule Quill.Repo.Migrations.CreatePage do
  use Ecto.Migration

  def change do
    create table(:pages) do
      add :name, :string
      add :slug, :string
      add :wiki_id, references(:wikis, on_delete: :nothing)

      timestamps()
    end
    create index(:pages, [:wiki_id])

  end
end
