defmodule Ap.Admin.PostControllerTest do
  use Ap.ConnCase

  alias Ap.Post
  alias Ap.User
  @valid_attrs %{content: "some content", page_title: "some content", published: false, title: "title", slug: "title"}

  @invalid_attrs %{}

  @user_attrs %{name: "Bharani", email: "test@test.com", password: "testing123"}


  setup do
    conn = build_conn()
    user = Repo.insert!(User.changeset(%User{}, @user_attrs))
    conn = post(conn, session_path(conn, :create, session: @user_attrs))

    {:ok, conn: conn, user: user}
  end


  test "lists all entries on index", %{conn: conn} do
    conn = get conn, admin_post_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing posts"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, admin_post_path(conn, :new)
    assert html_response(conn, 200) =~ "Add a new post"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, admin_post_path(conn, :create), post: @valid_attrs
    assert redirected_to(conn) == admin_post_path(conn, :index)
    assert Repo.get_by(Post, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, admin_post_path(conn, :create), post: @invalid_attrs
    assert html_response(conn, 200) =~ "Add a new post"
  end

  test "shows chosen resource", %{conn: conn} do
    post = Repo.insert! %Post{title: "Test post"}
    conn = get conn, admin_post_path(conn, :show, post)
    assert html_response(conn, 200) =~ "Test post"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, admin_post_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    post = Repo.insert! %Post{}
    conn = get conn, admin_post_path(conn, :edit, post)
    assert html_response(conn, 200) =~ "Edit"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    post = Repo.insert! %Post{}
    conn = put conn, admin_post_path(conn, :update, post), post: @valid_attrs
    assert redirected_to(conn) == admin_post_path(conn, :edit, post)
    assert Repo.get_by(Post, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    post = Repo.insert! %Post{}
    conn = put conn, admin_post_path(conn, :update, post), post: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit"
  end

  test "deletes chosen resource", %{conn: conn} do
    post = Repo.insert! %Post{}
    conn = delete conn, admin_post_path(conn, :delete, post)
    assert redirected_to(conn) == admin_post_path(conn, :index)
    refute Repo.get(Post, post.id)
  end
end
