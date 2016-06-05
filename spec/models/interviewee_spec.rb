require 'rails_helper'

RSpec.describe Interviewee, type: :model do

	context "checking columns" do
		it { should have_db_column(:name).of_type(:string)}
		it { should have_db_column(:gender).of_type(:integer)}
		it { should have_db_column(:number).of_type(:string)}
		it { should have_db_column(:email).of_type(:string)}
		it { should have_db_column(:phone).of_type(:string)}
		it { should have_db_column(:position_id).of_type(:integer)}
		it { should have_db_column(:interview_at).of_type(:datetime)}
		it { should have_db_column(:note).of_type(:string)}
		it { should have_db_column(:result).of_type(:string)}
		it { should have_db_column(:created_at).of_type(:datetime)}
		it { should have_db_column(:updated_at).of_type(:datetime)}
		it { should have_db_column(:status).of_type(:integer)}
		it { should have_db_column(:resume).of_type(:string)}
		it { should have_db_column(:interviewer_id).of_type(:integer)}
	end

	context "checking validations" do
  	it { should validate_presence_of(:name)}
  	it { should validate_presence_of(:gender)}
  	it { should validate_presence_of(:number)}
  	it { should validate_presence_of(:position_id)}
  end

  context "checking association" do
    it { should belong_to(:position) }
    it { should belong_to(:interviewer) }
    it { should have_many(:activities) }
  end

  context "checking callback" do

  	let(:interviewee){ create(:interviewee) }

  	context "before create" do

  		it "is status pending" do
  			expect(interviewee.status).to eq 'pending'
      end

  	end

  	context "after update" do

  		it "is status log update" do
  			interviewee.status = 'refuse_interview'
  			interviewee.save
  			expect(interviewee.activities.last.content).to eq "[系統] 狀態修改為#{I18n.t("enums.interviewee.status.#{interviewee.status}")}"
      end

  	end
  end
end
