class Applicant < ApplicationRecord
  belongs_to :decision_request
  has_many :credit_reports
  attr_encrypted :ssn, key: ENV["ENCRYPTION_KEY"]
end
