module TripsHelper

  def geocoded(trip)
    @geocoded ||= trip.places.inject([]) do |array,place|
      array << Gmaps4rails.geocode(place.name).first
    end
  end

  def polylines(trip)
    polylines = geocoded(trip).map do |geo|
      {lng: geo[:lng], lat: geo[:lat]}
    end
    [polylines]  # the API expects and array of polylines
  end
end
