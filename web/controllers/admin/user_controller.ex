defmodule Ap.Admin.UserController do
  use Ap.Web, :controller

  alias Ap.User
  plug :scrub_params, "user" when action in [:update]

  def edit(conn, %{"id" => id}) do
    user = Repo.get!(User, id)
    changeset = User.updation_changeset(user)
    render(conn, "edit.html", user: user, changeset: changeset)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Repo.get!(User, id)
    changeset = User.updation_changeset(user, user_params)

    case Repo.update(changeset) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "Profile updated successfully.")
        |> redirect(to: admin_user_path(conn, :edit, user))
      {:error, changeset} ->
        render(conn, "edit.html", user: user, changeset: changeset)
    end
  end

end
