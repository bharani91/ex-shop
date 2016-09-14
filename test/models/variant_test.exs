defmodule Ap.VariantTest do
  use Ap.ModelCase

  alias Ap.Variant

  @valid_attrs %{description: "some content", price: 42, purchase_url: "some content", title: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Variant.changeset(%Variant{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Variant.changeset(%Variant{}, @invalid_attrs)
    refute changeset.valid?
  end
end
