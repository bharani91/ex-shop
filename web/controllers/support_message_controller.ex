defmodule Ap.SupportMessageController do
  use Ap.Web, :controller

  alias Ap.SupportMessage
  alias Ap.Mailer

  plug :scrub_params, "support_message" when action in [:create]

  def new(conn, _params) do
    changeset = SupportMessage.changeset(%SupportMessage{})
    render conn, "new.html", changeset: changeset
  end

  def create(conn, %{ "support_message" => support_message_params }) do
    changeset = SupportMessage.changeset(%SupportMessage{}, support_message_params)

    case Repo.insert(changeset) do
      {:ok, support_message} ->

        Mailer.SupportMessage.thanks_for_contacting(support_message)
        |> Mailer.deliver_later

        Mailer.SupportMessage.new_support_message(support_message)
        |> Mailer.deliver_later

        conn
        |> put_flash(:info, "Thank you for contacting us. We will get back to you within 2 business days.")
        |> redirect(to: "/")
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end
end
