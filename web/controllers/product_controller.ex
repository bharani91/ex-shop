defmodule Ap.ProductController do
  use Ap.Web, :controller

  alias Ap.Product
  alias Ap.Variant
  alias Ap.ProductImage

  def index(conn, params) do
    products =
      Repo.all(Product)
      |> Repo.preload(:product_images)

    render(conn, "index.html", products: products)
  end

  def show(conn, %{"slug" => slug}) do
    product =
      Repo.get_by!(Product, slug: slug)
      |> Repo.preload([:product_categories])
      |> Repo.preload([variants: Variant.default_order, product_images: ProductImage.default_order])

    render(conn, "show.html", product: product)
  end
end
