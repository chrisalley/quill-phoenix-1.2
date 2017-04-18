defmodule Quill.ProfileTest do
  use Quill.ModelCase

  alias Quill.Profile

  @valid_attrs %{email: "some content", name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Profile.changeset(%Profile{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Profile.changeset(%Profile{}, @invalid_attrs)
    refute changeset.valid?
  end
end
