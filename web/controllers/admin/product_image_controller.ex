defmodule Ap.Admin.ProductImageController do
  use Ap.Web, :controller

  alias Ap.Product
  alias Ap.ProductImage

  def new(conn, %{"product_id" => product_id}) do
    product = Repo.get!(Product, product_id) |> Repo.preload(:product_images)

    changeset = product
    |> build_assoc(:product_images)
    |> ProductImage.changeset(%{})

    render(conn, "new.html", product: product, changeset: changeset)
  end

  def create(conn, %{"product_id" => product_id, "product_image" => %{ "file" => product_image_params}}) do
    product = Repo.get!(Product, product_id) |> Repo.preload(:product_images)
    client = Cloudini.new

    case Cloudini.upload_image(client, product_image_params.path, public_id: public_id(product_image_params.filename)) do
      {:ok, image} ->
        changeset =
          product
          |> build_assoc(:product_images)
          |> ProductImage.changeset(%{
              public_id: image["public_id"],
              url: image["url"],
              secure_url: image["secure_url"]
            })

        case Repo.insert(changeset) do
          {:ok, _product} ->
            conn
            |> put_flash(:info, "Image was uploaded successfully.")
            |> redirect(to: admin_product_image_path(conn, :new, product))
          {:error, changeset} ->
            render(conn, "new.html", changeset: changeset, product: product)
        end
      {:error, _} ->
        conn
        |> put_flash(:error, "Could not upload image. Please try again")
        |> redirect(to: admin_product_image_path(conn, :new, product))
    end
  end


  def delete(conn, %{"product_id" => product_id, "id" => id}) do
    product = Repo.get!(Product, product_id)
    image = Repo.get!(ProductImage, id)

    client = Cloudini.new
    {:ok, _} = Cloudini.delete_image(client, image.public_id)

    Repo.delete!(image)

    conn
    |> put_flash(:info, "Image was deleted successfully.")
    |> redirect(to: admin_product_image_path(conn, :new, product))
  end


  defp public_id(filename) do
    "#{filename}_#{:os.system_time(:milli_seconds)}"
  end
end
