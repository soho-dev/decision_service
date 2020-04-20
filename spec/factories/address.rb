FactoryGirl.define do
  factory :address do
    decision_request

    street "212 encounter bay"
    city "bay view"
    county "chapara"
    state "CA"
    zip "12345"

    trait :other_street do
      street "123 encounter bay"
    end
  end
end
