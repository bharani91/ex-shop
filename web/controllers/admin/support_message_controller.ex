defmodule Ap.Admin.SupportMessageController do
  use Ap.Web, :controller

  alias Ap.SupportMessage

  def index(conn, _params) do
    support_messages = Repo.all(SupportMessage)
    render(conn, "index.html", support_messages: support_messages)
  end

  def show(conn, %{"id" => id}) do
    support_message = Repo.get!(SupportMessage, id)
    render(conn, "show.html", support_message: support_message)
  end


  def delete(conn, %{"id" => id}) do
    support_message = Repo.get!(SupportMessage, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(support_message)

    conn
    |> put_flash(:info, "Support message deleted successfully.")
    |> redirect(to: admin_support_message_path(conn, :index))
  end
end
