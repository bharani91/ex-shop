defmodule Ap.User do
  use Ap.Web, :model
  import Ap.Utils.DowncaseEmail
  import Comeonin.Bcrypt, only: [hashpwsalt: 1]

  schema "users" do
    field :name, :string
    field :email, :string
    field :password_hash, :string
    field :bio, :string
    field :twitter_url, :string
    field :github_url, :string
    field :website_url, :string
    field :password, :string, virtual: true

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :email, :password])
    |> validate_required([:name, :email, :password])
    |> validate_format(:email, ~r/(.*?)\@\w+\.\w+/)
    |> validate_length(:password, min: 6, max: 25)
    |> downcase_email
    |> unique_constraint(:email)
    |> set_password_hash
  end

  def updation_changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :email, :bio, :twitter_url, :github_url, :website_url])
    |> validate_required([:name, :email])
    |> validate_format(:email, ~r/(.*?)\@\w+\.\w+/)
    |> validate_length(:password, min: 6, max: 25)
    |> downcase_email
    |> unique_constraint(:email)
  end

  defp set_password_hash(%{valid?: true, changes: %{password: password}}=changeset) do
    put_change(changeset, :password_hash, hashpwsalt(password))
  end

  defp set_password_hash(changeset), do: changeset

end
