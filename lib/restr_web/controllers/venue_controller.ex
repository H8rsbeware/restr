defmodule RestrWeb.VenueController do
  use RestrWeb, :controller

  alias Restr.Accounts
  alias Restr.Accounts.Venue

  action_fallback RestrWeb.FallbackController

  def index(conn, _params) do
    venues = Accounts.list_venues()
    render(conn, "index.json", venues: venues)
  end

  def create(conn, %{"venue" => venue_params}) do
    with {:ok, %Venue{} = venue} <- Accounts.create_venue(venue_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.venue_path(conn, :show, venue))
      |> render("show.json", venue: venue)
    end
  end

  def show(conn, %{"id" => id}) do
    venue = Accounts.get_venue!(id)
    render(conn, "show.json", venue: venue)
  end

  def update(conn, %{"id" => id, "venue" => venue_params}) do
    venue = Accounts.get_venue!(id)

    with {:ok, %Venue{} = venue} <- Accounts.update_venue(venue, venue_params) do
      render(conn, "show.json", venue: venue)
    end
  end

  def delete(conn, %{"id" => id}) do
    venue = Accounts.get_venue!(id)

    with {:ok, %Venue{}} <- Accounts.delete_venue(venue) do
      send_resp(conn, :no_content, "")
    end
  end
end
