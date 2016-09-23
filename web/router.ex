defmodule Ap.Router do
  use Ap.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :admin do
    plug :put_layout, {Ap.LayoutView, :admin}
    plug Ap.Plugs.Authenticate
  end


  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :default_assigns do
    plug Ap.Plugs.DefaultAssigns
  end

  if Mix.env == :dev do
    forward "/sent_emails", Bamboo.EmailPreviewPlug
  end


  scope "/admin", Ap.Admin, as: :admin do
    pipe_through [:browser, :admin]

    get "/", DashboardController, :index
    resources "/users", UserController, only: [:edit, :update]

    # Blog posts
    get "/posts/drafts", PostController, :drafts
    get "/posts/published", PostController, :published
    resources "/posts", PostController
    resources "/post-categories", PostCategoryController

    # Products
    resources "/products", ProductController do
      resources "/images", ProductImageController, only: [:new, :create, :delete], as: :image
    end
    resources "/product-categories", ProductCategoryController

    resources "/pages", PageController

    # Image management from WYSIWYG editor
    post "/editor-image-upload", EditorImageUploadController, :create
    delete "/editor-image-upload", EditorImageUploadController, :delete

    resources "/support-messages", SupportMessageController, only: [:index, :show, :delete]
  end

  scope "/", Ap do
    pipe_through [:browser, :default_assigns]

    get "/", HomeController, :index
    resources "/sessions", SessionController, only: [:new, :create, :delete]

    # Newsletter
    get "/newsletter-subscribe", NewsletterSubscribeController, :index

    # Support requests
    resources "/contact", SupportMessageController, only: [:new, :create]

    # Blog
    get "/blog/categories/:slug", PostCategoryController, :show
    get "/blog/archives", PostArchiveController, :index
    resources "/blog", PostController, only: [:index, :show]

    # Static Pages
    get "/pages/:slug", PageController, :show

    # Products
    get "/preview/:slug", ProductPreviewController, :show
    get "/products/:slug", ProductCategoryController, :show
    get "/product/:slug", ProductController, :show
  end


  # Other scopes may use custom stacks.
  # scope "/api", Ap do
  #   pipe_through :api
  # end
end
