defmodule ExPusherLite.EventsController do
  use ExPusherLite.Web, :controller

  def create(conn, params) do
    topic = params["topic"]
    event = params["event"]
    message = (params["payload"] || "{}") |> Poison.decode!
    ExPusherLite.Endpoint.broadcast! topic, event, message
    json conn, %{}
  end

end
