class Decision < ApplicationRecord
  belongs_to :decision_request

  def serialize
    {
      rule_name: rule_name,
      decision: decision,
      reason: reason
    }
  end
end
