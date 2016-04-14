FactoryGirl.define do
  factory :interviewee do
  	name 'Dennis'
  	gender 'male'
  	number '12345'
  	association :position, factory: :position
  end
end
