defmodule Ap.Admin.ProductControllerTest do
  use Ap.ConnCase

  alias Ap.Product
  alias Ap.ProductCategory
  alias Ap.User

  @valid_variant_attrs %{title: "test", purchase_url: "test.com", price: 10, description: "test"}

  @valid_attrs %{title: "Test Product 1", page_title: "Test Product 1", content: "Test Content", vendor: "creativemarket", demo_url: "http://google.com", variants: [@valid_variant_attrs], product_categories: [], featured: true, base_price: 10}

  @invalid_attrs %{}

  @user_attrs %{name: "Bharani", email: "test@test.com", password: "testing123"}
  @category_attrs %{title: "test", slug: "test", description: "test", featured: true}


  setup do
    conn = build_conn()
    user = Repo.insert!(User.changeset(%User{}, @user_attrs))
    conn = post(conn, session_path(conn, :create, session: @user_attrs))

    category = Repo.insert!(ProductCategory.changeset(%ProductCategory{}, @category_attrs))

    {:ok, conn: conn, user: user, category: category}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, admin_product_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing products"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, admin_product_path(conn, :new)
    assert html_response(conn, 200) =~ "Add a new product"
  end

  test "creates resource and redirects when data is valid", %{conn: conn, category: category} do

    attrs = %{@valid_attrs | product_categories: [to_string(category.id)]}

    conn = post conn, admin_product_path(conn, :create), product: attrs
    product = Repo.get_by(Product, title: attrs.title)
       |> Repo.preload(:product_categories)

    assert redirected_to(conn) == admin_product_image_path(conn, :new, product)



    assert product
    assert category in product.product_categories
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, admin_product_path(conn, :create), product: @invalid_attrs
    assert html_response(conn, 200) =~ "Add a new product"
  end

  test "shows chosen resource", %{conn: conn} do
    product = Repo.insert! Product.changeset(%Product{}, @valid_attrs)
    conn = get conn, admin_product_path(conn, :show, product)
    assert html_response(conn, 200) =~ product.title
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, admin_product_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    product = Repo.insert! %Product{}
    conn = get conn, admin_product_path(conn, :edit, product)
    assert html_response(conn, 200) =~ "Edit '#{product.title}'"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn, category: category} do
    product = Repo.insert! %Product{}
    attrs = %{@valid_attrs | product_categories: [to_string(category.id)]}
    conn = put conn, admin_product_path(conn, :update, product), product: attrs
    assert redirected_to(conn) == admin_product_image_path(conn, :new, product)
    assert Repo.get_by(Product, title: @valid_attrs.title)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    product = Repo.insert! %Product{}
    conn = put conn, admin_product_path(conn, :update, product), product: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit '#{product.title}'"
  end

  test "deletes chosen resource", %{conn: conn} do
    product = Repo.insert! %Product{}
    conn = delete conn, admin_product_path(conn, :delete, product)
    assert redirected_to(conn) == admin_product_path(conn, :index)
    refute Repo.get(Product, product.id)
  end
end
