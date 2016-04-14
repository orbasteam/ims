require 'rails_helper'

RSpec.describe Activity, type: :model do
  context "checking columns" do
		it { should have_db_column(:interviewee_id).of_type(:integer)}
		it { should have_db_column(:content).of_type(:string)}
	end

  context "checking association" do
    it { should belong_to(:interviewee) }
  end
end
