defmodule Quill.RevisionTest do
  use Quill.ModelCase

  alias Quill.Revision

  @valid_attrs %{content: "some content", name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Revision.changeset(%Revision{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Revision.changeset(%Revision{}, @invalid_attrs)
    refute changeset.valid?
  end
end
