class Applicant < ApplicationRecord
  belongs_to :decision_request
  has_many :credit_reports
end
