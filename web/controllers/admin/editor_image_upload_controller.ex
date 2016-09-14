defmodule Ap.Admin.EditorImageUploadController do
  use Ap.Web, :controller

  def create(conn, %{"file" => file_params}) do
    client = Cloudini.new

    {:ok, image} = Cloudini.upload_image(client, file_params.path, public_id: public_id(file_params.filename))

    render(conn, "upload.json", image: image)
  end

  def delete(conn, %{"src" => src}) do
    public_id = url_to_public_id(src)

    client = Cloudini.new
    {:ok, _} = Cloudini.delete_image(client, public_id)

    render(conn, "delete.json")
  end

  defp public_id(filename) do
    "#{filename}_#{:os.system_time(:milli_seconds)}"
  end

  defp url_to_public_id(url) do
    url
    |> to_string
    |> String.split("/")
    |> List.last
    |> String.replace(~r/\.\w{3,4}$/, "")
  end
end
