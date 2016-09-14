defmodule Ap.UserTest do
  use Ap.ModelCase

  alias Ap.User

  @valid_attrs %{name: "Test", email: "test@testing.com", password: "testing123"}
  @valid_updation_attrs %{name: "Test", email: "test@testing.com", password: "testing123", github_url: "http://github.com/username", twitter_url: "http://twitter.com/username", website_url: "website.com", bio: "testing"}

  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = User.changeset(%User{}, @valid_attrs)
    assert changeset.valid?
    assert changeset.changes[:password_hash]
  end

  test "changeset with invalid attributes" do
    changeset = User.changeset(%User{}, @invalid_attrs)
    refute changeset.valid?
  end

  test "updation changeset with valid attributes" do
    changeset = User.updation_changeset(%User{}, @valid_updation_attrs)
    assert changeset.valid?
    assert changeset.changes[:twitter_url]
    assert changeset.changes[:bio]
    assert changeset.changes[:website_url]
  end
end
