defmodule Ap.ProductImageTest do
  use Ap.ModelCase

  alias Ap.ProductImage

  @valid_attrs %{public_id: "some content", secure_url: "some content", url: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = ProductImage.changeset(%ProductImage{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = ProductImage.changeset(%ProductImage{}, @invalid_attrs)
    refute changeset.valid?
  end
end
