defmodule PhoenixElmBrunchExample.PageController do
  use PhoenixElmBrunchExample.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
