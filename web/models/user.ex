defmodule Quill.User do
  use Quill.Web, :model

  schema "users" do
    field :email, :string
    field :password, :string, virtual: true
    field :encrypted_password, :string
    belongs_to :profile, Quill.Profile

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:email])
    |> validate_required([:email])
    |> validate_length(:email, min: 1, max: 254)
  end

  def registration_changeset(struct, params) do
    struct
    |> changeset(params)
    |> cast(params, ~w(password), [])
    |> validate_length(:password, min: 6, max: 100)
    |> put_encrypted_password()
  end

  defp put_encrypted_password(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: pass}} ->
        put_change(
          changeset, :encrypted_password, Comeonin.Bcrypt.hashpwsalt(pass)
        )
      _ ->
        changeset
    end
  end
end
