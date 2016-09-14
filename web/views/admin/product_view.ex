defmodule Ap.Admin.ProductView do
  use Ap.Web, :view
  import Kerosene.HTML

  alias Ap.Product
  alias Ap.Variant

  def link_to_add_variant do
    changeset = Product.changeset(%Product{variants: [%Variant{}]})
    form = Phoenix.HTML.FormData.to_form(changeset, [])
    fields = render_to_string(__MODULE__, "variant_fields.html", f: form)
    link "Add another variant", to: "#", "data-template": fields, id: "add-variant-btn", class: "btn btn-default"
  end

end
