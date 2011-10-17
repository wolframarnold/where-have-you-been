require 'spec_helper'

describe TripsController do
  include Devise::TestHelpers

  context 'when not logged in' do

    context 'show or index action' do
      it 'renders view template'
    end

    context 'all other actions' do
      it 'redirects to login'
    end

  end

  context 'when logged in' do

    let(:valid_attributes) { {name: 'Chile'} }

    before do
      @trip = FactoryGirl.create(:trip)
      @user = @trip.user
      sign_in @trip.user
    end

    # Index and Show actions are public (anybody can view)

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

    # Edit, create, update, delete are specific to the user

    describe "GET edit -- authorized user" do
      it "assigns the requested trip as @trip" do
        get :edit, :id => @trip.id.to_s
        assigns(:trip).should eq(@trip)
      end
    end

    shared_examples_for 'response to unauthorized access' do
      it 'redirects to index with flash message' do
        response.should redirect_to(trips_path)
        flash[:alert].should == "You don't have permissions for this operation"
      end
    end

    describe "GET edit -- unauthorized user" do
      before do
        @trip2 = FactoryGirl.create(:trip)
        @user2 = @trip2.user
        @user.should_not be(@user2)
        get :edit, :id => @trip2.id.to_s
      end
      it_behaves_like 'response to unauthorized access'
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

      describe "when unauthorized" do
        before do
          @trip2 = FactoryGirl.create(:trip)
          @user2 = @trip2.user
          @user.should_not be(@user2)
          put :update, :id => @trip2.id.to_s
        end
        it_behaves_like 'response to unauthorized access'
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

      describe "when unauthorized" do
        before do
          @trip2 = FactoryGirl.create(:trip)
          @user2 = @trip2.user
          @user.should_not be(@user2)
          delete :destroy, :id => @trip2.id.to_s
        end
        it_behaves_like 'response to unauthorized access'
      end

    end

  end
end
