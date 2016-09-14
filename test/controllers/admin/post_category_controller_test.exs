defmodule Ap.PostCategoryControllerTest do
  use Ap.ConnCase

  alias Ap.PostCategory
  alias Ap.User

  @valid_attrs %{description: "some content", slug: "some content", title: "some content"}
  @invalid_attrs %{}

  @user_attrs %{name: "Bharani", email: "test@test.com", password: "testing123"}


  setup do
    conn = build_conn()
    user = Repo.insert!(User.changeset(%User{}, @user_attrs))
    conn = post(conn, session_path(conn, :create, session: @user_attrs))

    {:ok, conn: conn, user: user}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, admin_post_category_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing post categories"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, admin_post_category_path(conn, :new)
    assert html_response(conn, 200) =~ "Add a new post category"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, admin_post_category_path(conn, :create), post_category: @valid_attrs
    assert redirected_to(conn) == admin_post_category_path(conn, :index)
    assert Repo.get_by(PostCategory, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, admin_post_category_path(conn, :create), post_category: @invalid_attrs
    assert html_response(conn, 200) =~ "Add a new post category"
  end

  test "shows chosen resource", %{conn: conn} do
    post_category = Repo.insert! %PostCategory{title: "test"}
    conn = get conn, admin_post_category_path(conn, :show, post_category)
    assert html_response(conn, 200) =~ "test"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, admin_post_category_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    post_category = Repo.insert! %PostCategory{}
    conn = get conn, admin_post_category_path(conn, :edit, post_category)
    assert html_response(conn, 200) =~ "Edit"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    post_category = Repo.insert! %PostCategory{}
    conn = put conn, admin_post_category_path(conn, :update, post_category), post_category: @valid_attrs
    assert redirected_to(conn) == admin_post_category_path(conn, :show, post_category)
    assert Repo.get_by(PostCategory, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    post_category = Repo.insert! %PostCategory{}
    conn = put conn, admin_post_category_path(conn, :update, post_category), post_category: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit"
  end

  test "deletes chosen resource", %{conn: conn} do
    post_category = Repo.insert! %PostCategory{}
    conn = delete conn, admin_post_category_path(conn, :delete, post_category)
    assert redirected_to(conn) == admin_post_category_path(conn, :index)
    refute Repo.get(PostCategory, post_category.id)
  end
end
