defmodule Reviewcast.PageController do
  use Reviewcast.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

  def podcast(conn, _params) do
    render conn, "podcast.html"
  end
end
