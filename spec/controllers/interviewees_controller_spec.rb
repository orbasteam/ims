require 'rails_helper'

RSpec.describe IntervieweesController, type: :controller do

  let(:user) { create(:user) }
  let(:interviewee) { create(:interviewee) }

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

    it "assigns @interviewees" do
      sign_in user

      create(:interviewee)
      interviewee = create(:interviewee)
      interviewee.status = :no_response
      interviewee.save

      get :index
      expect(assigns(:interviewees).count).to eq 1
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

    it "assigns @interviewee" do
      sign_in user
      get :new
      expect(assigns(:interviewee)).to be_a Interviewee
    end
  end

  let(:valid_params) {
    {
      name: 'Dennis',
      gender: 'male',
      number: '12345',
      position_id: 1
    }
  }

  let(:invalid_params) {
    {
      name: '',
      gender: '',
      number: ''
    }
  }

  describe "POST #create" do

    render_views

    it_should_behave_like "checking auth" do
      subject { post :create }
    end

    context "create success" do

      before(:each) do
        sign_in user
        post :create, interviewee: valid_params
      end

      it "response redirect when success" do
        expect(response).to redirect_to interviewees_path
      end

      it "create data" do
        interviewee = Interviewee.last
        expect(assigns(:interviewee)).to eq interviewee
        expect(assigns(:interviewee)).to be_persisted
      end
    end

    it "render form when failed" do
      sign_in user
      post :create, interviewee: invalid_params
      expect(response).to render_template :form
    end

  end

  describe "GET #edit" do

    render_views

    it_should_behave_like "checking auth" do
      subject { get :edit, id: interviewee.to_param }
    end

    it "response success" do
      sign_in user
      get :edit, id: interviewee.to_param
      expect(response).to be_success
    end

    it "assigns :interviewee" do
      sign_in user
      get :edit, id: interviewee.to_param
      expect(assigns(:interviewee)).to eq interviewee
    end
  end

  describe "PUT #update" do

    render_views

    it_should_behave_like "checking auth" do
      subject { put :update, id: interviewee.to_param, interviewee: valid_params }
    end

    context "update success" do

      before(:each) {
        sign_in user
        put :update, id: interviewee.to_param, interviewee: valid_params
      }

      it "redirect success" do
        expect(response).to redirect_to interviewees_path
      end

      it "update success" do
        expect(assigns(:interviewee).name).to eq valid_params[:name]
        expect(assigns(:interviewee).number).to eq valid_params[:number]
        expect(assigns(:interviewee).gender).to eq valid_params[:gender]
      end

    end

  end

  describe "GET #calendar" do

    render_views

    it_should_behave_like "checking auth" do
      subject { get :calendar }
    end

    it "response success" do
      sign_in user
      get :calendar, format: :xml
      expect(response).to be_success
    end

  end

  describe "GET #result" do

    render_views

    it_should_behave_like "checking auth" do
      subject { get :result }
    end

    let "response success" do
      sign_in user
      get :result
      expect(response).to be_success
    end

  end

end
