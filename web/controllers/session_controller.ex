defmodule Ap.SessionController do
  use Ap.Web, :controller

  alias Ap.User
  import Comeonin.Bcrypt, only: [checkpw: 2]
  plug :scrub_params, "session" when action in [:create]

  def new(conn, _params) do
    render conn, "new.html"
  end

  def create(conn, %{"session" => %{"email" => email, "password" => password}}) when not is_nil(email) and not is_nil(password) do
    user = Repo.get_by(User, email: email |> String.downcase)
    sign_in(conn, user, password)
  end

  def create(conn, _) do
    failed_login(conn)
  end

  def delete(conn, _params) do
    conn
    |> put_flash(:info, "Signed out successfully")
    |> put_session(:current_user, nil)
    |> redirect(to: "/")
  end

  defp sign_in(conn, user, _password) when is_nil(user), do: failed_login(conn)
  defp sign_in(conn, %User{password_hash: hash}=user, password) do
    if checkpw(password, hash) do
      conn
      |> put_flash(:info, "Signed in successfully.")
      |> put_session(:current_user, user)
      |> redirect(to: admin_user_path(conn, :edit, user))
    else
      failed_login(conn)
    end
  end

  defp failed_login(conn) do
    conn
    |> put_flash(:error, "Invalid credentials. Please try again.")
    |> put_session(:current_user, nil)
    |> redirect(to: session_path(conn, :new))
    |> halt
  end
end
