defmodule Ap.Utils.Sluggify do
  import Ecto.Changeset, only: [put_change: 3, get_change: 2]

  def sluggify(%{valid?: true}=changeset) do
    sluggify(changeset, :title, :slug)
  end
  def sluggify(changeset), do: changeset


  def sluggify(%{valid?: true}=changeset, field, slug_field) do
    slug = get_change(changeset, slug_field)
    if slug do
      changeset
    else
      title = get_change(changeset, field)
      if title do
        put_change(changeset, slug_field, Slugger.slugify_downcase(title) )
      else
        changeset
      end
    end
  end
  def sluggify(changeset, _field, _slug), do: changeset
end
