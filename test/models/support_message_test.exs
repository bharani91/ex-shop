defmodule Ap.SupportMessageTest do
  use Ap.ModelCase

  alias Ap.SupportMessage

  @valid_attrs %{content: "some content", email: "some content", name: "some content", subject: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = SupportMessage.changeset(%SupportMessage{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = SupportMessage.changeset(%SupportMessage{}, @invalid_attrs)
    refute changeset.valid?
  end
end
