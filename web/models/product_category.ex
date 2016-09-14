defmodule Ap.ProductCategory do
  use Ap.Web, :model

  schema "product_categories" do
    field :title, :string
    field :slug, :string
    field :description, :string
    field :featured, :boolean

    many_to_many :products, Ap.Product, join_through: "products_categories", on_delete: :delete_all

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title, :slug, :description, :featured])
    |> validate_required([:title, :slug, :featured])
  end


  def find_for_select do
    from(c in __MODULE__, select: {c.title, c.id})
  end

  def only_featured do
    from(c in __MODULE__, where: c.featured == true, select: {c.title, c.slug})
  end
end
