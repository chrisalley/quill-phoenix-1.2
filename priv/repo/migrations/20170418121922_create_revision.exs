defmodule Quill.Repo.Migrations.CreateRevision do
  use Ecto.Migration

  def change do
    create table(:revisions) do
      add :name, :string
      add :content, :text
      add :page_id, references(:pages, on_delete: :nothing)
      add :profile_id, references(:profiles, on_delete: :nothing)

      timestamps()
    end
    create index(:revisions, [:page_id])
    create index(:revisions, [:profile_id])

  end
end
