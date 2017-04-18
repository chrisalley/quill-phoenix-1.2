defmodule Quill.Page do
  use Quill.Web, :model

  schema "pages" do
    field :name, :string
    field :slug, :string
    belongs_to :wiki, Quill.Wiki

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :slug])
    |> validate_required([:name, :slug])
  end
end
