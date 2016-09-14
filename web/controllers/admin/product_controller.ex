defmodule Ap.Admin.ProductController do
  use Ap.Web, :controller

  alias Ap.Product
  alias Ap.ProductCategory

  plug :scrub_params, "product" when action in [:create, :update]

  def index(conn, params) do
    {products, kerosene} = Product |> Repo.paginate(params)
    render(conn, "index.html", products: products, kerosene: kerosene)
  end

  def new(conn, _params) do
    changeset = Product.changeset(%Product{ product_categories: [] })
    categories = Repo.all(ProductCategory.find_for_select)

    render(conn, "new.html", changeset: changeset, categories: categories)
  end

  def create(conn, %{"product" => product_params}) do
    changeset = Product.changeset(%Product{product_categories: []}, product_params)
    categories = Repo.all(ProductCategory.find_for_select)


    case Repo.insert(changeset) do
      {:ok, product} ->
        conn
        |> put_flash(:info, "Product created successfully.")
        |> redirect(to: admin_product_image_path(conn, :new, product))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset, categories: categories)
    end
  end

  def show(conn, %{"id" => id}) do
    product = Repo.get!(Product, id)
    |> Repo.preload([:variants, :product_categories])

    render(conn, "show.html", product: product)
  end

  def edit(conn, %{"id" => id}) do
    product = Repo.get!(Product, id)
    |> Repo.preload([:variants, :product_categories])

    categories = Repo.all(ProductCategory.find_for_select)

    changeset = Product.changeset(product)
    render(conn, "edit.html", product: product, categories: categories, changeset: changeset)
  end

  def update(conn, %{"id" => id, "product" => product_params}) do
    product = Repo.get!(Product, id)
    |> Repo.preload([:variants, :product_categories])

    categories = Repo.all(ProductCategory.find_for_select)
    changeset = Product.changeset(product, product_params)

    case Repo.update(changeset) do
      {:ok, product} ->
        conn
        |> put_flash(:info, "Product updated successfully.")
        |> redirect(to: admin_product_image_path(conn, :new, product))
      {:error, changeset} ->
        render(conn, "edit.html", product: product, categories: categories, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    product = Repo.get!(Product, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(product)

    conn
    |> put_flash(:info, "Product deleted successfully.")
    |> redirect(to: admin_product_path(conn, :index))
  end
end
