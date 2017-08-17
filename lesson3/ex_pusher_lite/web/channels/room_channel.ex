defmodule ExPusherLite.RoomChannel do
  use ExPusherLite.Web, :channel

  # no auth is needed for public topics
  def join("public:" <> _topic_id, _auth_msg, socket) do
    {:ok, socket}
  end

  def join(topic, _resource, socket) do
    { :ok, %{ message: "Joined" }, socket }
  end

  def join(_room, _payload, _socket) do
    { :error, :authentication_required }
  end

  def handle_in(topic_event, payload, socket = %{ topic: "public:" <> _ }) do
    broadcast socket, topic_event, payload
    { :noreply, socket }
  end

  def handle_in(topic_event, payload, socket) do
      broadcast socket, topic_event, payload
      { :noreply, socket }
  end
end
