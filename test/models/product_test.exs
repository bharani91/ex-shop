defmodule Ap.ProductTest do
  use Ap.ModelCase

  alias Ap.Product

  @valid_variant_attrs %{title: "test", purchase_url: "test.com", price: 10, description: "test"}

  @valid_attrs %{title: "Test Product 1", page_title: "Test Product 1", content: "Test Content", vendor: "creativemarket", demo_url: "http://google.com", variants: [@valid_variant_attrs], base_price: 10, featured: false}

  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Product.changeset(%Product{}, @valid_attrs)
    assert changeset.valid?
  end

  test "set slug if empty" do
    changeset = Product.changeset(%Product{}, @valid_attrs)
    assert changeset.valid?
    assert changeset.changes[:slug]
    assert changeset.changes[:slug] == "test-product-1"
  end

  test "do not override slug if already set" do
    attrs = Map.put(@valid_attrs, :slug, "test-slug")

    changeset = Product.changeset(%Product{}, attrs)
    assert changeset.valid?
    assert changeset.changes[:slug] == "test-slug"
  end

  test "changeset with invalid attributes" do
    changeset = Product.changeset(%Product{}, @invalid_attrs)
    refute changeset.valid?
  end
end
