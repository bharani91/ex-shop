defmodule Ap.Admin.UserControllerTest do
  use Ap.ConnCase

  alias Ap.User

  @valid_attrs %{bio: "some content", email: "test@testing.com", github_url: "http://github.com/username", name: "Test", twitter_url: "http://twitter.com/username", password: "testing123"}

  @invalid_attrs %{}

  setup do
    conn = build_conn()
    user = Repo.insert!(User.changeset(%User{}, @valid_attrs))
    conn = post(conn, session_path(conn, :create, session: @valid_attrs))
    {:ok, conn: conn, user: user}
  end

  test "renders edit form", %{conn: conn} do
    user = Repo.insert! %User{}
    conn = get conn, admin_user_path(conn, :edit, user)
    assert html_response(conn, 200) =~ "Edit Profile"
  end

  test "updates user and redirects when data is valid", %{conn: conn, user: user} do
    conn = put conn, admin_user_path(conn, :update, user), user: @valid_attrs
    assert get_flash(conn, :info) =~ "Profile updated"
    assert redirected_to(conn) =~ admin_user_path(conn, :edit, user)
    assert Repo.get_by(User, email: @valid_attrs.email)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    user = Repo.insert! %User{}
    conn = put conn, admin_user_path(conn, :update, user), user: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit Profile"
  end
end
