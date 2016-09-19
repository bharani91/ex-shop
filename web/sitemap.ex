# defmodule Ap.Sitemap do
#   use PlainSitemap, app: :ap, default_host: "https://www.authenticpixels.com"
#
#   alias Ap.{Repo, Post, Page, Product, ProductCategory, PostCategory, Endpoint}
#   import Ap.Router.Helpers
#
#   urlset do
#     add "/", changefreq: "hourly", priority: 1.0
#
#     Product |> Repo.all |> Enum.each(fn(product) ->
#       add product_path(Endpoint, :show, product.slug), changefreq: "daily", priority: 0.9
#     end)
#
#     Post |> Repo.all |> Enum.each(fn(post) ->
#       add post_path(Endpoint, :show, post.slug), changefreq: "daily", priority: 0.8
#     end)
#
#     PostCategory |> Repo.all |> Enum.each(fn(category) ->
#       add post_category_path(Endpoint, :index, category.slug), changefreq: "daily", priority: 0.8
#     end)
#
#     ProductCategory |> Repo.all |> Enum.each(fn(category) ->
#       add product_category_path(Endpoint, :show, category.slug), changefreq: "daily", priority: 0.8
#     end)
#
#     Page |> Repo.all |> Enum.each(fn(page) ->
#       add page_path(Endpoint, :show, page.slug), changefreq: "daily", priority: 0.8
#     end)
#   end
# end
