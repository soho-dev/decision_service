FactoryGirl.define do
  factory :mortgage_report do
    address
    total_mortgage 10000
    pending_mortgage 100000
    regular_in_payment "regular"

    trait :failing_report do
      pending_mortgage 100001
    end
  end
end
