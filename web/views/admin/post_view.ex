defmodule Ap.Admin.PostView do
  use Ap.Web, :view
  import Kerosene.HTML

  def readable_datetime(datetime) do
    Timex.format!(datetime, "%B %e, %Y", :strftime)
  end
end
