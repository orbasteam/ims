FactoryGirl.define do
  factory :activity do
    association :interviewee, factory: :interviewee
    content 'content'
  end
end
