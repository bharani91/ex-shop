defmodule Ap.ProductCategoryController do
  use Ap.Web, :controller

  alias Ap.ProductCategory


  def show(conn, %{"slug" => slug}) do
    category =
      Repo.get_by!(ProductCategory, slug: slug)
      |> Repo.preload(products: [:product_images])

    render(conn, "show.html", category: category)
  end
end
