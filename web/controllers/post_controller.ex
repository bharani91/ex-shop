defmodule Ap.PostController do
  use Ap.Web, :controller

  alias Ap.Post
  alias Ap.User

  def index(conn, params) do
    {posts, kerosene} = Post.only_published |> Repo.paginate(params)
    render(conn, "index.html", posts: posts, kerosene: kerosene)
  end

  def show(conn, %{"id" => slug}) do
    post = Repo.get_by!(Post, slug: slug)
    admin = User |> first |> Repo.one
    render(conn, "show.html", post: post, admin: admin)
  end
end
