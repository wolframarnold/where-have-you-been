require 'spec_helper'

describe TripsController do
  include Devise::TestHelpers

  let(:valid_attributes) { {name: 'Chile', user_id: @trip.user_id} }

  before do
    @trip = FactoryGirl.create(:trip)
    sign_in @trip.user
  end

  describe "GET index" do
    it "assigns all trips as @trips" do
      get :index
      assigns(:trips).should eq([@trip])
    end
  end

  describe "GET show" do
    it "assigns the requested trip as @trip" do
      get :show, :id => @trip.id.to_s
      assigns(:trip).should eq(@trip)
    end
  end

  describe "GET new" do
    it "assigns a new trip as @trip" do
      get :new
      assigns(:trip).should be_a_new(Trip)
    end
  end

  describe "GET edit" do
    it "assigns the requested trip as @trip" do
      get :edit, :id => @trip.id.to_s
      assigns(:trip).should eq(@trip)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Trip" do
        expect {
          post :create, :trip => valid_attributes
        }.to change(Trip, :count).by(1)
      end

      it "assigns a newly created trip as @trip" do
        post :create, :trip => valid_attributes
        assigns(:trip).should be_a(Trip)
        assigns(:trip).should be_persisted
      end

      it "redirects to the created trip" do
        post :create, :trip => valid_attributes
        response.should redirect_to(Trip.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved trip as @trip" do
        # Trigger the behavior that occurs when invalid params are submitted
        Trip.any_instance.stub(:save).and_return(false)
        post :create, :trip => {}
        assigns(:trip).should be_a_new(Trip)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Trip.any_instance.stub(:save).and_return(false)
        post :create, :trip => {}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested trip" do
        expect {
          put :update, :id => @trip.id, :trip => {:name => 'Chile'}
        }.to change{@trip.reload.name}.from('Peru').to('Chile')
      end

      it "assigns the requested trip as @trip" do
        put :update, :id => @trip.id, :trip => valid_attributes
        assigns(:trip).should eq(@trip)
      end

      it "redirects to the trip" do
        put :update, :id => @trip.id, :trip => valid_attributes
        response.should redirect_to(@trip)
      end
    end

    describe "with invalid params" do
      it "assigns the trip as @trip" do
        # Trigger the behavior that occurs when invalid params are submitted
        Trip.any_instance.stub(:save).and_return(false)
        put :update, :id => @trip.id.to_s, :trip => {}
        assigns(:trip).should eq(@trip)
      end

      it "re-renders the 'edit' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Trip.any_instance.stub(:save).and_return(false)
        put :update, :id => @trip.id.to_s, :trip => {}
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested trip" do
      expect {
        delete :destroy, :id => @trip.id.to_s
      }.to change(Trip, :count).by(-1)
    end

    it "redirects to the trips list" do
      delete :destroy, :id => @trip.id.to_s
      response.should redirect_to(trips_url)
    end
  end

end
