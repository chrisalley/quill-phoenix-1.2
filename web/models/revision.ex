defmodule Quill.Revision do
  use Quill.Web, :model

  schema "revisions" do
    field :name, :string
    field :content, :string
    belongs_to :page, Quill.Page
    belongs_to :profile, Quill.Profile

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :content])
    |> validate_required([:name, :content])
  end
end
