FactoryGirl.define do
  factory :activity do
    association :interviewee, factory: :interviewee
  end
end
