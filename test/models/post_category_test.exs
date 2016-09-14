defmodule Ap.PostCategoryTest do
  use Ap.ModelCase

  alias Ap.PostCategory

  @valid_attrs %{description: "some content", slug: "some content", title: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = PostCategory.changeset(%PostCategory{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = PostCategory.changeset(%PostCategory{}, @invalid_attrs)
    refute changeset.valid?
  end
end
