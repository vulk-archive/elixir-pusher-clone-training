defmodule ExPusherLite.EventsControllerTest do
  use ExPusherLite.ConnCase

  alias ExPusherLite.Events
  @valid_attrs %{}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, events_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    events = Repo.insert! %Events{}
    conn = get conn, events_path(conn, :show, events)
    assert json_response(conn, 200)["data"] == %{"id" => events.id}
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, events_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, events_path(conn, :create), events: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Events, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, events_path(conn, :create), events: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    events = Repo.insert! %Events{}
    conn = put conn, events_path(conn, :update, events), events: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Events, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    events = Repo.insert! %Events{}
    conn = put conn, events_path(conn, :update, events), events: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    events = Repo.insert! %Events{}
    conn = delete conn, events_path(conn, :delete, events)
    assert response(conn, 204)
    refute Repo.get(Events, events.id)
  end
end
