defmodule Quill.Repo.Migrations.CreateProfile do
  use Ecto.Migration

  def change do
    create table(:profiles) do
      add :name, :string
      add :email, :string

      timestamps()
    end

  end
end
