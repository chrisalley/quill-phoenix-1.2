defmodule Quill.Page do
  use Quill.Web, :model

  schema "pages" do
    field :name, :string
    field :slug, :string
    belongs_to :wiki, Quill.Wiki

    timestamps()
  end

  @required_fields ~w(name wiki_id)
  @optional_fields ~w(slug)

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @required_fields, @optional_fields)
    |> put_slug()
  end

  defp put_slug(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{name: name}} ->
        put_change(changeset, :slug, Slugger.slugify_downcase(name))
      _ ->
        changeset
    end
  end
end
