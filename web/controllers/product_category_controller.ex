defmodule Ap.ProductCategoryController do
  use Ap.Web, :controller

  alias Ap.ProductCategory
  alias Ap.ProductImage


  def show(conn, %{"slug" => slug}) do
    category =
      Repo.get_by!(ProductCategory, slug: slug)
      |> Repo.preload(products: [product_images: ProductImage.default_order])

    render(conn, "show.html", category: category)
  end
end
