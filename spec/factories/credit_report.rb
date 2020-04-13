FactoryGirl.define do
  factory :credit_report do
    applicant
    credit_score 6

    trait :bad_report do
      credit_score 2
    end
  end
end
