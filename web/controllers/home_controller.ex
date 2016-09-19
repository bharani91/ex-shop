defmodule Ap.HomeController do
  use Ap.Web, :controller

  alias Ap.Product
  alias Ap.ProductImage

  def index(conn, _params) do
    products = Repo.all(Product.only_featured) |> Repo.preload([product_images: ProductImage.default_order])
    render(conn, "index.html", products: products)
  end
end
