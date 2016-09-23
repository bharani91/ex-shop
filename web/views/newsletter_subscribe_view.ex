defmodule Ap.NewsletterSubscribeView do
  use Ap.Web, :view

  def render("meta.index.html", assigns) do
    post = assigns[:post]
    ~E{
    <title>Subscribe To Our Newsletter - Authentic Pixels</title>
    }
  end

end
