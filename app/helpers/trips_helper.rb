module TripsHelper

  def geocoded
    @geocoded ||= @trip.places.inject([]) do |array,place|
      array << Gmaps4rails.geocode(place.name).first
    end
  end

  def polylines
    polylines = geocoded.map do |geo|
      {lng: geo[:lng], lat: geo[:lat]}
    end
    [polylines]  # the API expects and array of polylines
  end
end
