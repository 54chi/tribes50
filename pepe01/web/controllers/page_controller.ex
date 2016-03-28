defmodule Pepe01.PageController do
  use Pepe01.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
