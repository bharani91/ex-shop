defmodule Ap.NewsletterSubscribeController do
  use Ap.Web, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
