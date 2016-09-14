defmodule Ap.PostTest do
  use Ap.ModelCase

  alias Ap.Post

  @valid_attrs %{content: "some content", page_title: "some content", published: false, title: "title"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Post.changeset(%Post{}, @valid_attrs)
    assert changeset.valid?
    assert changeset.changes[:slug]
    refute changeset.changes[:published_at]
  end

  test "set published at when published" do
    attrs = %{@valid_attrs | published: true}
    changeset = Post.changeset(%Post{}, attrs)
    assert changeset.valid?

    published_at = changeset.changes[:published_at]
    assert published_at
    assert published_at.day == DateTime.utc_now.day
  end

  test "don't update published_at if already set" do
    attrs = %{@valid_attrs | published: true}
    changeset = Post.changeset(%Post{}, attrs)
    post = Repo.insert! changeset
    published_at = post.published_at


    changeset = Post.changeset(post, %{title: "new title"})
    updated_post = Repo.update!(changeset)

    assert updated_post.published_at == published_at
  end

  test "changeset with invalid attributes" do
    changeset = Post.changeset(%Post{}, @invalid_attrs)
    refute changeset.valid?
  end
end
