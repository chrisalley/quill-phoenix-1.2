defmodule Quill.Wiki do
  use Quill.Web, :model

  schema "wikis" do
    field :name, :string
    field :slug, Quill.NameSlug.Type
    field :description, :string

    timestamps()
  end

  @required_fields ~w(name description)
  @optional_fields ~w(slug)

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @required_fields, @optional_fields)
    |> Quill.NameSlug.maybe_generate_slug
    |> Quill.NameSlug.unique_constraint
  end
end
