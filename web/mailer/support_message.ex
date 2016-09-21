defmodule Ap.Mailer.SupportMessage do
  use Bamboo.Phoenix, view: Ap.MailerView


  def thanks_for_contacting(support_message) do
    base_email
    |> to(support_message.email)
    |> subject("Thanks for contacting Authentic Pixels.")
    |> assign(:subject, support_message.subject)
    |> assign(:message, support_message.content)
    |> render("thanks_for_contacting.html")
  end

  def new_support_message(support_message) do

    base_email
    |> to("bharani@authenticpixels.com")
    |> from(support_message.email)
    |> subject(support_message.subject || "New Support Message")
    |> assign(:subject, support_message.subject)
    |> assign(:message, support_message.content)
    |> render("new_support_message.html")

  end


  defp base_email do
    new_email
    |> from("Bharani M <bharani@authenticpixels.com>")
    |> put_header("Reply-To", "bharani@authenticpixels.com")
    |> put_html_layout({Ap.MailerView, "base.html"})
  end
end
