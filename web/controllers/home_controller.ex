defmodule Ap.HomeController do
  use Ap.Web, :controller

  alias Ap.Product

  def index(conn, _params) do
    products = Repo.all(Product.only_featured) |> Repo.preload(:product_images)
    render(conn, "index.html", products: products)
  end
end
