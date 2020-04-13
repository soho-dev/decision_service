FactoryGirl.define do
  factory :mortgage_report do
    address
    total_mortgage 10000
    pending_mortgage 5000
    regular_in_payment "regular"

    trait :bad_report do
      pending_mortgage 10000
    end
  end
end
