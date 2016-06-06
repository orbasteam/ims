require 'rails_helper'

RSpec.describe ActivitiesController, type: :controller do

  let(:user) { create(:user) }
  let(:activity) { create(:activity) }
  let(:interviewee) { activity.interviewee }

  describe "GET #index" do

    it_should_behave_like "checking auth" do
      subject { get :index, interviewee_id: interviewee.id }
    end

    it "response success" do
      sign_in user
      get :index,  interviewee_id: interviewee.id
      expect(response).to be_success
    end

    it "assigns @activities" do
      create(:interviewee)
      sign_in user

      get :index,  interviewee_id: activity.interviewee.id
      expect(assigns(:activities).count).to eq 1
    end

  end

  let(:valid_params) { { content: 'content' } }
  let(:invalid_params) { { content: '' } }

  describe "POST #create" do

    it_should_behave_like "checking auth" do
      subject { post :create, interviewee_id: interviewee.id, activity: valid_params }
    end

    it "redirect when success" do
      sign_in user
      post :create, interviewee_id: interviewee.id, activity: valid_params
      expect(response).to redirect_to edit_interviewee_path(interviewee.id)
    end

    it "redirect when failed" do
      sign_in user
      post :create, interviewee_id: interviewee.id, activity: invalid_params
      expect(response).to redirect_to edit_interviewee_path(interviewee.id)
    end

    it "create data" do
      sign_in user
      post :create, interviewee_id: interviewee.id, activity: valid_params
      expect(assigns(:activity)).to eq Activity.last
    end

  end

end