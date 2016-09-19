defmodule Ap.PostView do
  use Ap.Web, :view
  import Kerosene.HTML

  def readable_datetime(datetime) do
    Timex.format!(datetime, "%B %e, %Y", :strftime)
  end

  def truncate_post(post) do
    Curtail.truncate(post.content, length: 10000, break_token: "<!-- truncate -->")
  end

  def render("meta.show.html", assigns) do
    post = assigns[:post]
    ~E{
    <title><%= post.page_title %> - Authentic Pixels</title>
    <meta name="description" content="<%= post.meta_description %>" />
    }
  end

  def render("meta.index.html", assigns) do
    post = assigns[:post]
    ~E{
    <title>Recent Blog Posts - Authentic Pixels</title>
    }
  end

  def render("social_meta.show.html", assigns) do
    post = assigns[:post]
    ~E{
    <meta property="og:title" content="<%= post.page_title %> - Authentic Pixels">
    <meta property="og:description" content="<%= post.meta_description %>">
    <meta property="og:image" content="<%= post.featured_image %>">

    <meta name="twitter:title" content="<%= post.page_title %> - Authentic Pixels">
    <meta name="twitter:description" content="<%= post.meta_description %>">
    <meta name="twitter:image" content="<%= post.featured_image %>">

    <meta itemprop="name" content="<%= post.page_title %> - Authentic Pixels">
    <meta itemprop="description" content="<%= post.meta_description %>">
    <meta itemprop="image" content="<%= post.featured_image %>">
    }
  end
end
