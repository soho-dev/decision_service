FactoryGirl.define do
  factory :decision do
    decision_request
    rule_name "test_rule"
    decision "eligible"
    message "you are eligible"

    trait :decline do
      decision "decline"
      message "you are not eligible"
    end
  end
end
