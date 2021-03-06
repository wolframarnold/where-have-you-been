class TripsController < ApplicationController
  before_filter :authenticate_user!, :except => [:show, :index]
  before_filter :find_trip_if_authorized, only: [:edit,:update,:destroy]

  # GET /trips
  # GET /trips.json
  def index
    @trips = Trip.desc.all
    @latest_trip = @trips.first

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @trips }
    end
  end

  # GET /trips/1
  # GET /trips/1.json
  def show
    @trip = Trip.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @trip }
    end
  end

  # GET /trips/new
  # GET /trips/new.json
  def new
    @trip = current_user.trips.build
    5.times {@trip.places.build}

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @trip }
    end
  end

  # GET /trips/1/edit
  def edit
    (5-@trip.places.count).times {@trip.places.build}
  end

  # POST /trips
  # POST /trips.json
  def create
    @trip = current_user.trips.build(params[:trip])

    respond_to do |format|
      if @trip.save
        format.html { redirect_to @trip, notice: 'Trip was successfully created.' }
        format.json { render json: @trip, status: :created, location: @trip }
      else
        format.html { render action: "new" }
        format.json { render json: @trip.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /trips/1
  # PUT /trips/1.json
  def update
    respond_to do |format|
      if @trip.update_attributes(params[:trip])
        format.html { redirect_to @trip, notice: 'Trip was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @trip.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /trips/1
  # DELETE /trips/1.json
  def destroy
    @trip.destroy

    respond_to do |format|
      format.html { redirect_to trips_url }
      format.json { head :ok }
    end
  end

  private

  def find_trip_if_authorized
    @trip = current_user.trips.find_by_id(params[:id])
    if @trip.nil?
      flash[:alert] = "You don't have permissions for this operation"
      redirect_to trips_path
    end
  end

end
