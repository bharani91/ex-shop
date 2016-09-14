defmodule Ap.LayoutView do
  use Ap.Web, :view

  import Ap.Utils.FlashMessages

  def current_user(conn) do
    Plug.Conn.get_session(conn, :current_user)
  end

  def active_class(conn, path) do
    current_path = Path.join(["/" | conn.path_info])
    if path == current_path do
      "active"
    else
      nil
    end
  end

  def render("meta.html", _assigns) do
    ~E{
    <title>Authentic Pixels - Free & Premium Boostrap Templates</title>
    <meta type="description" content="We deliver free Bootstrap themes -  admin/dashboard templates, startup landing pages, UI kits, mockups, landing pages & other web/design resources." />
    }
  end

  def render("social_meta.html", _assigns) do
    ~E{
    <meta property="og:title" content="Free & Premium Web Resources">
    <meta property="og:image" content="https://www.authenticpixels.com/images/authentic-pixels-facebook.png">
    <meta property="og:description" content="We deliver free Bootstrap themes & templates, UI kits, mockups, landing pages & other web/design resources.">

    <meta name="twitter:title" content="Free & Premium Web Resources by Authentic Pixels">
    <meta name="twitter:description" content="We deliver free Bootstrap themes & templates, UI kits, mockups, landing pages & other web/design resources.">
    <meta name="twitter:image" content="https://www.authenticpixels.com/images/authentic-pixels-facebook.png">


    <meta itemprop="name" content="Free & Premium Web Resources by Authentic Pixels">
    <meta itemprop="description" content="We deliver free Bootstrap themes & templates, UI kits, mockups, landing pages & other web/design resources.">
    <meta itemprop="image" content="https://www.authenticpixels.com/images/authentic-pixels-facebook.png">
    }
  end

  def render("common_social_meta.html", _assigns) do
    ~E{
    <meta property="fb:app_id" content="123456789">
    <meta property="og:url" content="https://www.authenticpixels.com">
    <meta property="og:type" content="website">
    <meta property="og:site_name" content="Authentic Pixels">
    <meta property="og:locale" content="en_US">

    <meta name="twitter:card" content="summary">
    <meta name="twitter:site" content="@authenticPx">
    <meta name="twitter:creator" content="@bharani91">
    <link href="https://plus.google.com/u/0/b/112322022330320721172/112322022330320721172" rel="publisher">
    }
  end
end
