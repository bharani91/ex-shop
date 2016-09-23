defmodule Ap.PostCategoryController do
  use Ap.Web, :controller

  alias Ap.PostCategory
  alias Ap.Post


  def show(conn, %{"slug" => slug}) do
    category =
      Repo.get_by!(PostCategory, slug: slug)
      |> Repo.preload([posts: Post.only_published])

    render(conn, "show.html", category: category)
  end
end
