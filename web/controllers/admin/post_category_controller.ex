defmodule Ap.Admin.PostCategoryController do
  use Ap.Web, :controller

  alias Ap.PostCategory

  plug :scrub_params, "post_category" when action in [:create, :update]

  def index(conn, _params) do
    categories = Repo.all(PostCategory)
    render(conn, "index.html", categories: categories)
  end

  def new(conn, _params) do
    changeset = PostCategory.changeset(%PostCategory{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"post_category" => post_category_params}) do
    changeset = PostCategory.changeset(%PostCategory{}, post_category_params)

    case Repo.insert(changeset) do
      {:ok, _post_category} ->
        conn
        |> put_flash(:info, "Post category created successfully.")
        |> redirect(to: admin_post_category_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    category = Repo.get!(PostCategory, id) |> Repo.preload(:posts)
    render(conn, "show.html", category: category)
  end

  def edit(conn, %{"id" => id}) do
    category = Repo.get!(PostCategory, id)
    changeset = PostCategory.changeset(category)
    render(conn, "edit.html", category: category, changeset: changeset)
  end

  def update(conn, %{"id" => id, "post_category" => post_category_params}) do
    category = Repo.get!(PostCategory, id)
    changeset = PostCategory.changeset(category, post_category_params)

    case Repo.update(changeset) do
      {:ok, category} ->
        conn
        |> put_flash(:info, "Post category updated successfully.")
        |> redirect(to: admin_post_category_path(conn, :show, category))
      {:error, changeset} ->
        render(conn, "edit.html", category: category, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    category = Repo.get!(PostCategory, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(category)

    conn
    |> put_flash(:info, "Post category deleted successfully.")
    |> redirect(to: admin_post_category_path(conn, :index))
  end
end
