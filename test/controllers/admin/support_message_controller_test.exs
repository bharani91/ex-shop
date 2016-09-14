defmodule Ap.Admin.SupportMessageControllerTest do
  use Ap.ConnCase

  alias Ap.SupportMessage
  alias Ap.User
  @valid_attrs %{content: "some content", email: "some content", name: "some content", subject: "some content"}
  @invalid_attrs %{}

  @user_attrs %{name: "Bharani", email: "test@test.com", password: "testing123"}


  setup do
    conn = build_conn()
    user = Repo.insert!(User.changeset(%User{}, @user_attrs))
    conn = post(conn, session_path(conn, :create, session: @user_attrs))

    {:ok, conn: conn, user: user}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, admin_support_message_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing support messages"
  end


  test "shows chosen resource", %{conn: conn} do
    support_message = Repo.insert! %SupportMessage{email: "test@testing.com", subject: "Test Subject"}
    conn = get conn, admin_support_message_path(conn, :show, support_message)
    assert html_response(conn, 200) =~ "Test Subject"
  end


  test "deletes chosen resource", %{conn: conn} do
    support_message = Repo.insert! %SupportMessage{}
    conn = delete conn, admin_support_message_path(conn, :delete, support_message)
    assert redirected_to(conn) == admin_support_message_path(conn, :index)
    refute Repo.get(SupportMessage, support_message.id)
  end
end
