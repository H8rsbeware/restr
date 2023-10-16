defmodule RestrWeb.VenueControllerTest do
  use RestrWeb.ConnCase

  alias Restr.Accounts
  alias Restr.Accounts.Venue

  @create_attrs %{
    name: "some name",
    capacity: 42
  }
  @update_attrs %{
    name: "some updated name",
    capacity: 43
  }
  @invalid_attrs %{name: nil, capacity: nil}

  def fixture(:venue) do
    {:ok, venue} = Accounts.create_venue(@create_attrs)
    venue
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all venues", %{conn: conn} do
      conn = get(conn, Routes.venue_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create venue" do
    test "renders venue when data is valid", %{conn: conn} do
      conn = post(conn, Routes.venue_path(conn, :create), venue: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.venue_path(conn, :show, id))

      assert %{
               "id" => id,
               "capacity" => 42,
               "name" => "some name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.venue_path(conn, :create), venue: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update venue" do
    setup [:create_venue]

    test "renders venue when data is valid", %{conn: conn, venue: %Venue{id: id} = venue} do
      conn = put(conn, Routes.venue_path(conn, :update, venue), venue: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.venue_path(conn, :show, id))

      assert %{
               "id" => id,
               "capacity" => 43,
               "name" => "some updated name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, venue: venue} do
      conn = put(conn, Routes.venue_path(conn, :update, venue), venue: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete venue" do
    setup [:create_venue]

    test "deletes chosen venue", %{conn: conn, venue: venue} do
      conn = delete(conn, Routes.venue_path(conn, :delete, venue))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.venue_path(conn, :show, venue))
      end
    end
  end

  defp create_venue(_) do
    venue = fixture(:venue)
    %{venue: venue}
  end
end
