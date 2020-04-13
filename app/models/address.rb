class Address < ApplicationRecord
  belongs_to :decision_request
  has_many :mortgage_reports
end
