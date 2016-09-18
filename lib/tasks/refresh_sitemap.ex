defmodule Ap.Tasks.RefreshSitemap do
  def perform do
    Ap.Sitemap.refresh
    ping
  end

  defp ping do
    urls = ~w(http://google.com/ping?sitemap=%s
    http://www.bing.com/webmaster/ping.aspx?sitemap=%s)

    root = Ap.Router.Helpers.home_url(Ap.Endpoint, :index)
    sitemap_url = "#{root}sitemap.xml.gz"

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
