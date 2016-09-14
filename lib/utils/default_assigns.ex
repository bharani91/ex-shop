defmodule Ap.Plugs.DefaultAssigns do
  alias Ap.Repo
  alias Ap.ProductCategory

  import Plug.Conn

  def init(default), do: default

  def call(conn, _default) do
    product_categories = Repo.all(ProductCategory.only_featured)
    assign(conn, :product_categories, product_categories)
  end

end
