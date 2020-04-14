require 'reports'
class Reports::Credit < Reports
  protected

  def other_fields
    { applicant_id: request_payload.id }
  end

  def request_payload
    decision_request.applicant
  end

  def service
    "ReportService::ApplicantDataService"
  end

  def parser
    "ReportParser::Applicant"
  end

  def report_class
    "CreditReport"
  end
end
