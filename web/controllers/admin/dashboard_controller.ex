defmodule Ap.Admin.DashboardController do
  use Ap.Web, :controller

  alias Ap.Post
  alias Ap.Product

  def index(conn, _params) do
    posts = Repo.all(from Post, order_by: [desc: :inserted_at], limit: 5)
    products = Repo.all(from Product, order_by: [desc: :inserted_at], limit: 5)

    render conn, "index.html", posts: posts, products: products
  end
end
