defmodule ExPusherLite.EventsView do
  use ExPusherLite.Web, :view

  def render("index.json", %{events: events}) do
    %{data: render_many(events, ExPusherLite.EventsView, "events.json")}
  end

  def render("show.json", %{events: events}) do
    %{data: render_one(events, ExPusherLite.EventsView, "events.json")}
  end

  def render("events.json", %{events: events}) do
    %{id: events.id}
  end
end
