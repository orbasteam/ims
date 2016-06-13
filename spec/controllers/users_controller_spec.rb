require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  let(:user) { create(:user) }

  describe "GET #edit" do

    render_views

    it_should_behave_like "checking auth" do
      subject { get :edit }
    end

    it "response success" do
      sign_in user
      get :edit
      expect(response).to be_success
    end

  end

  let(:valid_params) {
    {
      name: 'Name',
      password: 'password',
      password_confirmation: 'password',
      current_password: '12345678'
    }
  }

  let(:invalid_params) {
    {
      name: 'Name',
      password: '1234',
      password_confirmation: '123',
      current_password: ''
    }
  }

  describe "PUT #update" do

    render_views

    it_should_behave_like "checking auth" do
      subject { put :update}
    end

    it "redirect to edit_user_path when success" do
      sign_in user
      put :update, user: valid_params
      expect(response).to redirect_to edit_user_path
    end

    it "render form when failed" do
      sign_in user
      put :update, user: invalid_params
      expect(response).to render_template :form
    end

    it "update user" do
      sign_in user
      put :update, user: valid_params
      expect(assigns(:user).name).to eq 'Name'
      expect(assigns(:user).valid_password?('password')).to eq true
    end

  end

end
