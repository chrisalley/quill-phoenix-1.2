defmodule Quill.WikiTest do
  use Quill.ModelCase

  alias Quill.Wiki

  @valid_attrs %{description: "some content", name: "some content", slug: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Wiki.changeset(%Wiki{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Wiki.changeset(%Wiki{}, @invalid_attrs)
    refute changeset.valid?
  end
end
