defmodule Ap.Admin.EditorImageUploadView do
  use Ap.Web, :view

  def render("upload.json", %{ image: %{ "secure_url" => url } }) do
    %{
      "link": url
    }
  end

  def render("delete.json", %{}) do
    %{
      "status": "success"
    }
  end
end
