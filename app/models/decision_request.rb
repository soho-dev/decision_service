class DecisionRequest < ApplicationRecord
  has_many :decisions
  has_one :applicant
  has_one :address

  def serialize
    {
      application_id: application_id,
      address: address.serialize,
      applicant: applicant.serialize,
      final_decision: decision,
      decision: decisions.map{ |decision| decision.serialize },
      funding_options: funding_options
    }
  end

  def funding_options
    if decision == "eligible"
      [
        {
          years: 5,
          interest_rate: 6,
          emi: 100
        },
        {
          years: 10,
          interest_rate: 6,
          emi: 60
          }
        ]
    else
      []
    end
  end
end
