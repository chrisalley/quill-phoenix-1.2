defmodule Quill.Repo.Migrations.CreateWiki do
  use Ecto.Migration

  def change do
    create table(:wikis) do
      add :name, :string
      add :slug, :string
      add :description, :text

      timestamps()
    end

  end
end
