defmodule Ap.Post do
  use Ap.Web, :model
  import Ap.Utils.Sluggify
  import Ap.Utils.ManyToMany

  schema "posts" do
    field :title, :string
    field :slug, :string
    field :page_title, :string
    field :meta_description, :string
    field :content, :string
    field :published, :boolean, default: false
    field :published_at, Ecto.DateTime
    field :featured_image, :string
    many_to_many :post_categories, Ap.PostCategory, join_through: "posts_categories", on_delete: :delete_all

    timestamps()
  end

  def all_posts do
    from p in __MODULE__,
      order_by: [desc: p.inserted_at]
  end

  def only_drafts do
    from p in __MODULE__,
      where: p.published == false,
      order_by: [desc: p.inserted_at]
  end

  def only_published do
    from p in __MODULE__,
      where: p.published == true,
      order_by: [desc: p.inserted_at]
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title, :slug, :page_title, :meta_description, :content, :published])
    |> validate_required([:title, :page_title, :content, :published])
    |> map_many_to_many_ids_to_records(:post_categories, Ap.PostCategory)
    |> sluggify
    |> unique_constraint(:slug)
    |> set_published_at_if_published
    |> upload_featured_image_and_set_path
  end

  defp set_published_at_if_published(%{valid?: true}=changeset) do
    published = get_change(changeset, :published)
    published_at = changeset.data.published_at

    if published_at do
      changeset
    else
      if published do
        put_change(changeset, :published_at, Ecto.DateTime.utc)
      else
        changeset
      end
    end
  end

  defp set_published_at_if_published(changeset), do: changeset


  defp upload_featured_image_and_set_path(%{valid?: true}=changeset) do
    case Map.fetch(changeset.params, "image") do
      {:ok, file} ->
        client = Cloudini.new

        {:ok, image} = Cloudini.upload_image(client, file.path, public_id: public_id(file.filename))

        put_change(changeset, :featured_image, image["secure_url"])
      :error ->
        changeset
    end
  end
  defp upload_featured_image_and_set_path(changeset), do: changeset

  defp public_id(filename) do
    "#{filename}_#{:os.system_time(:milli_seconds)}"
  end
end
