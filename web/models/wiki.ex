defmodule Quill.Wiki do
  use Quill.Web, :model

  schema "wikis" do
    field :name, :string
    field :slug, :string
    field :description, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :slug, :description])
    |> validate_required([:name, :slug, :description])
  end
end
