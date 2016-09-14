defmodule Ap.ProductImage do
  use Ap.Web, :model

  schema "product_image" do
    field :public_id, :string
    field :url, :string
    field :secure_url, :string
    belongs_to :product, Ap.Product

    timestamps()
  end

  def default_order do
    from c in __MODULE__, order_by: [asc: c.id]
  end
  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:public_id, :url, :secure_url])
    |> validate_required([:public_id, :url, :secure_url])
  end
end
