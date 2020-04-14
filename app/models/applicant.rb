class Applicant < ApplicationRecord
  belongs_to :decision_request
  has_many :credit_reports
  attr_encrypted :ssn, key: ENV["ENCRYPTION_KEY"]

  def serialize
    {
      first_name: first_name,
      last_name: last_name,
      ssn: ssn,
      income: income
    }
  end
end
