class ReportParser::Applicant
  def self.parse(payload = {})
    {
      credit_score: payload["credit_score"]
    }
  end
end
