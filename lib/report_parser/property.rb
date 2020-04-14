class ReportParser::Property
  def self.parse(payload = {})
    {
      total_mortgage: payload["total_mortgage_amount"],
      pending_mortgage: payload["pending_mortgage_amount"],
      regular_in_payment: payload["regular_in_payment"]
    }
  end
end
