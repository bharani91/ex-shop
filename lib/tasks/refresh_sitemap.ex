defmodule Ap.Tasks.RefreshSitemap do
  import XmlBuilder
  import Ap.Router.Helpers
  alias Ap.{Repo, Post, Page, Product, ProductCategory, PostCategory, Endpoint}

  @host "https://www.authenticpixels.com"
  @default_output_dir "priv/static"
  @output_file_name "sitemap.xml"
  @sitemap_public_path "/uploads/sitemap.xml"

  def generate do
    path =
      System.get_env("STORAGE_DIR")
      |> Path.join(@output_file_name)

    {:ok, file} = File.open path, [:utf8, :write]
    IO.write file, render
    File.close file
    ping
  end

  defp render do
    doc(:urlset, urlset_attributes, urls)
  end

  defp urls do
    home = element(:url, %{}, [
      element(:loc, @host),
      element(:changefreq, "daily"),
      element(:priority, 1.0)
    ])

    subscribe = element(:url, %{}, [
      element(:loc, "#{@host}#{newsletter_subscribe_path(Endpoint, :index)}"),
      element(:changefreq, "weekly"),
      element(:priority, 0.9)
    ])

    blog = element(:url, %{}, [
      element(:loc, "#{@host}/blog"),
      element(:changefreq, "daily"),
      element(:priority, 0.9)
    ])

    contact = element(:url, %{}, [
      element(:loc, "#{@host}/contact/new"),
      element(:changefreq, "weekly"),
      element(:priority, 0.8)
    ])

    list = [home, subscribe, blog, contact]
    list = [list | product_urls]
    list = [list | post_urls]
    list = [list | page_urls]
    list = [list | product_category_urls]
    list = [list | post_category_urls]
  end

  defp page_urls do
    Page |> Repo.all |> Enum.map fn(page) ->
      element(:url, %{}, [
        element(:loc, "#{@host}#{page_path(Endpoint, :show, page.slug)}"),
        element(:changefreq, "weekly"),
        element(:priority, 0.8)
      ])
    end
  end

  defp product_urls do
    Product |> Repo.all |> Enum.map fn(product) ->
      element(:url, %{}, [
        element(:loc, "#{@host}#{product_path(Endpoint, :show, product.slug)}"),
        element(:changefreq, "weekly"),
        element(:priority, 0.9)
      ])
    end
  end

  defp post_urls do
    Post |> Repo.all |> Enum.map fn(post) ->
      element(:url, %{}, [
        element(:loc, "#{@host}#{post_path(Endpoint, :show, post.slug)}"),
        element(:changefreq, "weekly"),
        element(:priority, 0.8)
      ])
    end
  end

  defp product_category_urls do
    ProductCategory |> Repo.all |> Enum.map fn(product_category) ->
      element(:url, %{}, [
        element(:loc, "#{@host}#{product_category_path(Endpoint, :show, product_category.slug)}"),
        element(:changefreq, "daily"),
        element(:priority, 0.8)
      ])
    end
  end

  defp post_category_urls do
    PostCategory |> Repo.all |> Enum.map fn(post_category) ->
      element(:url, %{}, [
        element(:loc, "#{@host}#{post_category_path(Endpoint, :index, post_category.slug)}"),
        element(:changefreq, "daily"),
        element(:priority, 0.8)
      ])
    end
  end

  defp urlset_attributes do
    %{
      :"xmlns:xsi" => "http://www.w3.org/2001/XMLSchema-instance",
      :"xsi:schemaLocation" => "http://www.sitemaps.org/schemas/sitemap/0.9 http://www.sitemaps.org/schemas/sitemap/0.9/sitemap.xsd",
      :"xmlns" => "http://www.sitemaps.org/schemas/sitemap/0.9",
      :"xmlns:image" => "http://www.google.com/schemas/sitemap-image/1.1",
      :"xmlns:video" => "http://www.google.com/schemas/sitemap-video/1.1",
      :"xmlns:geo" => "http://www.google.com/geo/schemas/sitemap/1.0",
      :"xmlns:news" => "http://www.google.com/schemas/sitemap-news/0.9",
      :"xmlns:mobile" => "http://www.google.com/schemas/sitemap-mobile/1.0",
      :"xmlns:pagemap" => "http://www.google.com/schemas/sitemap-pagemap/1.0",
      :"xmlns:xhtml" => "http://www.w3.org/1999/xhtml"
    }
  end

  defp ping do
    urls = ~w(http://google.com/ping?sitemap=%s
    http://www.bing.com/webmaster/ping.aspx?sitemap=%s)

    sitemap_url = "#{@host}#{@sitemap_public_path}"
    :application.start(:inets)
    Enum.each urls, fn url ->
      spawn(fn ->
        ping_url = String.replace(url, "%s", sitemap_url)
        :httpc.request('#{ping_url}')
        IO.puts "Successful ping of #{ping_url}"
      end)
    end
  end
end
