defmodule Pepe02Api.Router do
  use Pepe02Api.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  #scope "/", Pepe02Api do
  #  pipe_through :browser # Use the default browser stack

  #  get "/", PageController, :index
  #end

  # Other scopes may use custom stacks.
  scope "/api", Pepe02Api do
    pipe_through :api
     
    scope "/v1" do
      resources "/stories", V1.StoryController
    end
  end
end
