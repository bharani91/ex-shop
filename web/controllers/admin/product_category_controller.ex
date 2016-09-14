defmodule Ap.Admin.ProductCategoryController do
  use Ap.Web, :controller

  alias Ap.ProductCategory

  plug :scrub_params, "product_category" when action in [:create, :update]

  def index(conn, _params) do
    categories = Repo.all(ProductCategory)
    render(conn, "index.html", categories: categories)
  end

  def new(conn, _params) do
    changeset = ProductCategory.changeset(%ProductCategory{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"product_category" => product_category_params}) do
    changeset = ProductCategory.changeset(%ProductCategory{}, product_category_params)

    case Repo.insert(changeset) do
      {:ok, _product} ->
        conn
        |> put_flash(:info, "Product Category created successfully.")
        |> redirect(to: admin_product_category_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    category = Repo.get!(ProductCategory, id) |> Repo.preload(:products)
    render(conn, "show.html", category: category)
  end

  def edit(conn, %{"id" => id}) do
    category = Repo.get!(ProductCategory, id)

    changeset = ProductCategory.changeset(category)
    render(conn, "edit.html", category: category, changeset: changeset)
  end

  def update(conn, %{"id" => id, "product_category" => product_category_params}) do
    category = Repo.get!(ProductCategory, id)
    changeset = ProductCategory.changeset(category, product_category_params)

    case Repo.update(changeset) do
      {:ok, category} ->
        conn
        |> put_flash(:info, "Product Category updated successfully.")
        |> redirect(to: admin_product_category_path(conn, :show, category))
      {:error, changeset} ->
        render(conn, "edit.html", category: category, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    category = Repo.get!(ProductCategory, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(category)

    conn
    |> put_flash(:info, "Product deleted successfully.")
    |> redirect(to: admin_product_category_path(conn, :index))
  end
end
