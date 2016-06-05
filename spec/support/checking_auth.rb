require 'set'

shared_examples_for "checking auth" do

  let(:admin) {
    FactoryGirl.create(:user, :admin)
  }

  it "redirect to sign in page" do
    expect(subject).to redirect_to(new_user_session_path)
  end

end