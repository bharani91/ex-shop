defmodule Ap.ProductPreviewController do
  use Ap.Web, :controller

  alias Ap.Product

  plug :put_layout, {Ap.LayoutView, "preview.html"}


  def show(conn, %{"slug" => slug}) do
    product =
      Repo.get_by!(Product, slug: slug)

    render(conn, "show.html", product: product)
  end
end
