defmodule Ap.ProductCategoryTest do
  use Ap.ModelCase

  alias Ap.ProductCategory

  @valid_attrs %{description: "some content", slug: "some content", title: "some content", featured: false}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = ProductCategory.changeset(%ProductCategory{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = ProductCategory.changeset(%ProductCategory{}, @invalid_attrs)
    refute changeset.valid?
  end
end
