defmodule Ap.PostCategory do
  use Ap.Web, :model

  schema "post_categories" do
    field :title, :string
    field :slug, :string
    field :description, :string
    many_to_many :posts, Ap.Post, join_through: "posts_categories", on_delete: :delete_all

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title, :slug, :description])
    |> validate_required([:title, :slug, :description])
  end

  def find_for_select do
    from(c in __MODULE__, select: {c.title, c.id})
  end
end
