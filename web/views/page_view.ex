defmodule Ap.PageView do
  use Ap.Web, :view

  def render("meta.show.html", assigns) do
    page = assigns[:page]
    ~E{
    <title><%= page.page_title %> - Authentic Pixels</title>
    }
  end
end
