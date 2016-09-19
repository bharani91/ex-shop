defmodule Ap.SupportMessageView do
  use Ap.Web, :view

  def render("meta.new.html", assigns) do
    ~E{
    <title>Contact Us - Authentic Pixels</title>
    <meta name="description" content="Please send your comments & suggestions using this contact form. For a faster response, feel free to send us a message on Facebook/Twitter." />
    }
  end
end
