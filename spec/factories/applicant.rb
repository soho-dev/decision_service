FactoryGirl.define do
  factory :applicant do
    decision_request

    first_name "first"
    last_name "last"
    ssn "123456789"
    income 10000
    income_type "salary"
    requested_loan_amount 100000

    trait :different_ssn do
      income 9999
    end
  end
end
