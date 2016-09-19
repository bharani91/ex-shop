defmodule Ap.Tasks.RefreshSitemap do
  import XmlBuilder
  alias Ap.{Repo, Post, Page, Product, ProductCategory, PostCategory, Endpoint}

  @host "https://www.authenticpixels.com/"
  @default_output_dir "priv/static"
  @output_file_name "sitemap.xml"

  def generate do
    path =
      System.get_env("STORAGE_DIR") || @default_output_dir
      |> Path.join(@output_file_name)

    {:ok, file} = File.open path, [:utf8, :write]
    IO.write file, render
    File.close file
    # ping
  end

  defp render do
    doc(:urlset, urlset_attributes, [urls])
  end

  defp urls do
    home = element(:url, %{}, [
      element(:loc, "@default_host}"),
      element(:changefreq, "daily"),
      element(:priority, 1.0)
    ])

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

    sitemap_url = "#{@host}sitemap.xml"

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
