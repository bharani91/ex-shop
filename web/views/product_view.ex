defmodule Ap.ProductView do
  use Ap.Web, :view

  def featured_image_url([img | _]) do
    img.secure_url || img.url
  end

  def default_purchase_url([variant | _]), do: variant.purchase_url
  def default_purchase_url([]), do: ""

  def readable_price([variant | _]), do: readable_price(variant.price)
  def readable_price([]), do: ""
  def readable_price(num) do
    if num == 0 do
      "Free"
    else
      "$#{num}"
    end
  end

  def alternate_class_name(id, size, _direction) when rem(id, 2) == 0 do
    "col-md-#{size}"
  end

  def alternate_class_name(id, size, direction) do
    alt_size = 12 - size
    "col-md-#{size} col-md-#{direction}-#{alt_size}"
  end

  def render("meta.show.html", assigns) do
    product = assigns[:product]

    ~E{
    <title><%= product.page_title %> - Authentic Pixels</title>
    <meta name="description" content="<%= product.meta_description || product.extract %>" />
    }
  end

  def render("social_meta.show.html", assigns) do
    product = assigns[:product]
    conn = assigns.conn
    url = Ap.Router.Helpers.url(conn) <> conn.request_path


    ~E{
    <meta property="og:url" content="<%= url %>">
    <meta property="og:title" content="<%= product.page_title %> - Authentic Pixels">
    <meta property="og:description" content="<%= product.meta_description || product.extract %>">
    <meta property="og:image" content="<%= featured_image_url(product.product_images) %>">

    <meta name="twitter:title" content="<%= product.page_title %> - Authentic Pixels">
    <meta name="twitter:description" content="<%= product.meta_description || product.extract %>">
    <meta name="twitter:image" content="<%= featured_image_url(product.product_images) %>">

    }
  end
end
