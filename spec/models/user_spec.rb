require 'rails_helper'

RSpec.describe User, type: :model do

  context "checking columns" do
    it { should have_db_column(:name).of_type(:string) }
  end

  context "checking association" do
    it { have_many(:interviewees) }
  end

end
