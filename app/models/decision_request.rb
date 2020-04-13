class DecisionRequest < ApplicationRecord
  has_many :decisions
  has_one :applicant
  has_one :address
end
