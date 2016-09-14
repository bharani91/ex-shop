defmodule Ap.Variant do
  use Ap.Web, :model

  schema "variants" do
    field :title, :string
    field :description, :string
    field :price, :integer
    field :purchase_url, :string
    field :delete, :boolean, virtual: true
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
    |> cast(params, [:title, :description, :price, :purchase_url, :delete])
    |> validate_required([:title, :description, :price, :purchase_url])
    |> mark_for_deletion
  end

  defp mark_for_deletion(changeset) do
    if get_change(changeset, :delete) do
      %{changeset | action: :delete}
    else
      changeset
    end
  end
end
