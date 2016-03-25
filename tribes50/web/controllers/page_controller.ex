defmodule Tribes50.PageController do
  use Tribes50.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
