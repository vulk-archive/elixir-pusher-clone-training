defmodule ExPusherLite.EventsController do
  use ExPusherLite.Web, :controller
  use Guardian.Phoenix.Controller

  def create(conn, params, user, claims) do
    topic = params["topic"]
    event = params["event"]
    message = (params["payload"] || "{}") |> Poison.decode!
    ExPusherLite.Endpoint.broadcast! topic, event, message
    json conn, %{}
  end

end
