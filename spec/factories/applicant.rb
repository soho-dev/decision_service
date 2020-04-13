FactoryGirl.define do
  factory :applicant do
    first_name "first"
    last_name "last"
    ssn "123456789"
    income 10000
    income_type "salary"
    requested_loan_amount 100000

    trait :different_ssn do
      ssn "999999999"
    end
  end
end
