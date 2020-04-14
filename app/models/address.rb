class Address < ApplicationRecord
  belongs_to :decision_request
  has_many :mortgage_reports

  def serialize
    {
      street: street,
      city: city,
      zip: zip,
      state: state,
      county: county
    }
  end
end
