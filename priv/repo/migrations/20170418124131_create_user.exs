defmodule Quill.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :email, :string
      add :encrypted_password, :string
      add :profile_id, references(:profiles, on_delete: :nothing)

      timestamps()
    end
    create index(:users, [:profile_id])

  end
end
