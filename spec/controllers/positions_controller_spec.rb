require 'rails_helper'

RSpec.describe PositionsController, type: :controller do

  let(:user) { create(:user) }
  let(:position) { create(:position) }

	describe "GET #index" do

    render_views

    it_should_behave_like "checking auth" do
      subject { get :index }
    end

    it "response success" do
      sign_in user
      get :index
      expect(response).to be_success
    end

    it "assigns @positions" do
      sign_in user
      get :index
      expect(assigns(:positions)).to eq Position.all
    end
  end

	describe "GET #new" do

    render_views

    it_should_behave_like "checking auth" do
      subject { get :new }
    end

    it "response success" do
      sign_in user
      get :new
      expect(response).to be_success
    end

    it "assigns @position" do
      sign_in user
      get :new
      expect(assigns(:position)).to be_a Position
    end

  end

  let(:valid_params) {
    {
      name: 'Engineer'
    }
  }

  let(:invalid_params) { { name: '' } }

  describe "POST #create" do

    render_views

    it_should_behave_like "checking auth" do
      subject { post :create, position: valid_params }
    end

    context "create success" do

      before(:each) do
        sign_in user
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
      sign_in user
      post :create, position: invalid_params
      expect(response).to render_template :form
    end

  end

  describe "GET #edit" do

    render_views

    it_should_behave_like "checking auth" do
      subject { get :edit, id: position.to_param }
    end

    it "response success" do
      sign_in user
      get :edit, id: position.to_param
      expect(response).to be_success
    end

    it "assigns :position" do
      sign_in user
      get :edit, id: position.to_param
      expect(assigns(:position)).to eq position
    end

  end

  describe "PUT #update" do

  	render_views

    it_should_behave_like "checking auth" do
      subject { put :update, id: position.to_param, position: valid_params }
    end

  	it "response redirect when success" do
      sign_in user
  		put :update, id: position.to_param, position: valid_params
  		expect(response).to redirect_to edit_position_path position.to_param
  	end

  	it "render :edit when failed" do
      sign_in user
  		put :update, id: position.to_param, position: invalid_params
  		expect(response).to render_template :form
  	end

  	it "assigns @position" do
      sign_in user
  		put :update, id: position.to_param, position: valid_params
  		expect(assigns(:position).name).to eq valid_params[:name]
  	end
  end
end
