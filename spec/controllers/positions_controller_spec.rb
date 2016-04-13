require 'rails_helper'

RSpec.describe PositionsController, type: :controller do

	describe "GET #index" do

    render_views

    it "response success" do
      get :index
      expect(response).to be_success
    end

    it "assigns @positions" do
      get :index
      expect(assigns(:positions)).to eq Position.all
    end
  end

	describe "GET #new" do

    render_views

    it "response success" do
      get :new
      expect(response).to be_success
    end

    it "assigns @position" do
      get :new
      expect(assigns(:position)).to be_a Position
    end

  end

  let(:valid_params) { { name: 'Engineer' } }
  let(:invalid_params) { { name: '' } }

  describe "POST #create" do

    render_views

    context "create success" do

      before(:each) do
        post :create, position: valid_params
      end

      it "response redirect when success" do
        position = Position.last
        expect(response).to redirect_to edit_position_path(position.id)
      end

      it "create data" do
        position = Position.last
        expect(assigns(:position)).to eq position
        expect(assigns(:position)).to be_persisted
      end

    end

    it "render :new when failed" do
      post :create, position: invalid_params
      expect(response).to render_template :form
    end

  end

  let(:position) { FactoryGirl.create(:position) }

  describe "GET #edit" do

    render_views

    it "response success" do
      get :edit, id: position.to_param
      expect(response).to be_success
    end

    it "assigns :position" do
      get :edit, id: position.to_param
      expect(assigns(:position)).to eq position
    end

  end

  describe "PUT :update" do
  	render_views
  	it "response redirect when success" do
  		put :update, id: position.to_param, position: valid_params
  		expect(response).to redirect_to edit_position_path position.to_param
  	end

  	it "render :edit when failed" do
  		put :update, id: position.to_param, position: invalid_params
  		expect(response).to render_template :form
  	end

  	it "assigns @position" do
  		put :update, id: position.to_param, position: valid_params
  		expect(assigns(:position).name).to eq valid_params[:name]
  	end
  end
end
