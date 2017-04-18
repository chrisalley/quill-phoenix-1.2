defmodule Quill.PageTest do
  use Quill.ModelCase

  alias Quill.Page

  @valid_attrs %{name: "some content", slug: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Page.changeset(%Page{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Page.changeset(%Page{}, @invalid_attrs)
    refute changeset.valid?
  end
end
