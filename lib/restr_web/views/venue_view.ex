defmodule RestrWeb.VenueView do
  use RestrWeb, :view
  alias RestrWeb.VenueView

  def render("index.json", %{venues: venues}) do
    %{data: render_many(venues, VenueView, "venue.json")}
  end

  def render("show.json", %{venue: venue}) do
    %{data: render_one(venue, VenueView, "venue.json")}
  end

  def render("venue.json", %{venue: venue}) do
    %{id: venue.id,
      name: venue.name,
      capacity: venue.capacity}
  end
end
