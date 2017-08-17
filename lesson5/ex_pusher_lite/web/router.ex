defmodule ExPusherLite.Router do
  use ExPusherLite.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    # plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :guardian do
    plug Guardian.Plug.VerifyHeader, realm: "Bearer"
    plug Guardian.Plug.LoadResource
  end

  scope "/", ExPusherLite do
    pipe_through [ :browser, :guardian]

    get "/", PageController, :index
    post "/events", EventsController, :create
  end

end
