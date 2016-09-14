defmodule Ap.PageControllerTest do
  use Ap.ConnCase

  alias Ap.Page
  alias Ap.User

  @valid_attrs %{content: "some content", page_title: "some content", slug: "some content", title: "some content"}
  @invalid_attrs %{}

  @user_attrs %{name: "Bharani", email: "test@test.com", password: "testing123"}


  setup do
    conn = build_conn()
    user = Repo.insert!(User.changeset(%User{}, @user_attrs))
    conn = post(conn, session_path(conn, :create, session: @user_attrs))

    {:ok, conn: conn, user: user}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, admin_page_path(conn, :index)
    assert html_response(conn, 200) =~ "Static Pages"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, admin_page_path(conn, :new)
    assert html_response(conn, 200) =~ "Add a new page"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, admin_page_path(conn, :create), page: @valid_attrs
    assert redirected_to(conn) == admin_page_path(conn, :index)
    assert Repo.get_by(Page, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, admin_page_path(conn, :create), page: @invalid_attrs
    assert html_response(conn, 200) =~ "Add a new page"
  end

  test "shows chosen resource", %{conn: conn} do
    page = Repo.insert! %Page{title: "test title"}
    conn = get conn, admin_page_path(conn, :show, page)
    assert html_response(conn, 200) =~ "test title"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, admin_page_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    page = Repo.insert! %Page{}
    conn = get conn, admin_page_path(conn, :edit, page)
    assert html_response(conn, 200) =~ "Edit"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    page = Repo.insert! %Page{}
    conn = put conn, admin_page_path(conn, :update, page), page: @valid_attrs
    assert redirected_to(conn) == admin_page_path(conn, :show, page)
    assert Repo.get_by(Page, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    page = Repo.insert! %Page{}
    conn = put conn, admin_page_path(conn, :update, page), page: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit"
  end

  test "deletes chosen resource", %{conn: conn} do
    page = Repo.insert! %Page{}
    conn = delete conn, admin_page_path(conn, :delete, page)
    assert redirected_to(conn) == admin_page_path(conn, :index)
    refute Repo.get(Page, page.id)
  end
end
