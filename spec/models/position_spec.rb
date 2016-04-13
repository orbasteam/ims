require 'rails_helper'

RSpec.describe Position, type: :model do
  context "checking columns" do
		it { should have_db_column(:name).of_type(:string)}
	end

	context "checking validations" do
  	it { should validate_presence_of(:name)}
  end

  context "checking association" do
    it { should have_many(:interviewees) }
  end
end
