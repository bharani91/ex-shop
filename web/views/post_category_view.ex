defmodule Ap.PostCategoryView do
  use Ap.Web, :view

  def render("meta.show.html", assigns) do
    category = assigns[:category]
    ~E{
    <title><%= category.title %> - Authentic Pixels</title>
    <meta type="description" content="<%= category.description %>" />
    }
  end
end
