FactoryGirl.define do
  factory :address do
    decision_request

    street "123 encounter bay"
    city "bay view"
    county "chapara"
    state "CA"
    zip "12345"

    trait :other_street do
      street "321 encounter bay"
    end
  end
end
