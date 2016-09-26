defmodule Ap.Product do
  use Ap.Web, :model
  import Ap.Utils.Sluggify
  import Ap.Utils.ManyToMany

  schema "products" do
    field :title, :string
    field :slug, :string
    field :page_title, :string
    field :content, :string
    field :vendor, :string
    field :demo_url, :string
    field :meta_description, :string
    field :extract, :string
    field :featured, :boolean
    field :base_price, :integer

    has_many :variants, Ap.Variant
    has_many :product_images, Ap.ProductImage
    many_to_many :product_categories, Ap.ProductCategory, join_through: "products_categories", on_delete: :delete_all

    timestamps()
  end

  def available_vendors do
    [
      "Gumroad": "gumroad",
      "Creative Market": "creativemarket",
      "Wrap Bootstrap": "wrapbootstrap"
    ]
  end

  def only_featured do
    from p in __MODULE__,
      where: p.featured == true,
      order_by: [desc: p.inserted_at]
  end

  def default_order(preloads \\ []) do
    from p in __MODULE__,
      order_by: [desc: p.inserted_at],
      preload: ^preloads
  end


  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title, :slug, :page_title, :content, :vendor, :demo_url, :meta_description, :extract, :featured, :base_price])
    |> cast_assoc(:variants, required: true)
    |> map_many_to_many_ids_to_records(:product_categories, Ap.ProductCategory)
    |> validate_required([:title, :page_title, :content, :vendor, :demo_url, :featured, :base_price])
    |> validate_length(:password, min: 6, max: 144)
    |> unique_constraint(:title)
    |> sluggify
    |> unique_constraint(:slug)
  end

  defp validate_presence_of_categories(changeset) do
    data = changeset.data
    changes = get_change(changeset, :product_categories)

    if data.product_categories == [] and !changes  do
      add_error(changeset, :product_categories, "can't be empty")
    else
      changeset
    end
  end

end
