defmodule Ap.PageController do
  use Ap.Web, :controller

  alias Ap.Page


  def show(conn, %{"slug" => slug}) do
    page = Repo.get_by!(Page, slug: slug)
    render(conn, "show.html", page: page)
  end
end
