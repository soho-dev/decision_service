FactoryGirl.define do
  to_create { |instance| instance.save }

  factory :decision_request do
    application_id 123
    association :applicant
    association :address
  end
end
