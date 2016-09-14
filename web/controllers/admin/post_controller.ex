defmodule Ap.Admin.PostController do
  use Ap.Web, :controller

  alias Ap.Post
  alias Ap.PostCategory

  plug :scrub_params, "post" when action in [:create, :update]

  plug :set_categories when action in [:new, :create, :edit, :update]

  def index(conn, params) do
    {posts, kerosene} = Post.all_posts |> Repo.paginate(params)
    render(conn, "index.html", posts: posts, kerosene: kerosene)
  end

  def drafts(conn, params) do
    {posts, kerosene} = Post.only_drafts |> Repo.paginate(params)
    render(conn, "index.html", posts: posts, kerosene: kerosene)
  end

  def published(conn, params) do
    {posts, kerosene} = Post.only_published |> Repo.paginate(params)
    render(conn, "index.html", posts: posts, kerosene: kerosene)
  end

  def new(conn, _params) do
    changeset = Post.changeset(%Post{post_categories: []})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"post" => post_params}) do
    changeset = Post.changeset(%Post{post_categories: []}, post_params)

    case Repo.insert(changeset) do
      {:ok, _post} ->
        conn
        |> put_flash(:info, "Post created successfully.")
        |> redirect(to: admin_post_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    post = Repo.get!(Post, id)
    |> Repo.preload([:post_categories])

    render(conn, "show.html", post: post)
  end

  def edit(conn, %{"id" => id}) do
    post = Repo.get!(Post, id)
    |> Repo.preload([:post_categories])

    changeset = Post.changeset(post)
    render(conn, "edit.html", post: post, changeset: changeset)
  end

  def update(conn, %{"id" => id, "post" => post_params}) do
    post = Repo.get!(Post, id)
    |> Repo.preload([:post_categories])

    changeset = Post.changeset(post, post_params)

    case Repo.update(changeset) do
      {:ok, post} ->
        conn
        |> put_flash(:info, "Post updated successfully.")
        |> redirect(to: admin_post_path(conn, :edit, post))
      {:error, changeset} ->
        render(conn, "edit.html", post: post, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    post = Repo.get!(Post, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(post)

    conn
    |> put_flash(:info, "Post deleted successfully.")
    |> redirect(to: admin_post_path(conn, :index))
  end


  defp set_categories(conn, _params) do
    assign(conn, :categories, Repo.all(PostCategory.find_for_select))
  end

end
