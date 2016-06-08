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

end
