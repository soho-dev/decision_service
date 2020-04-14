require 'reports'
class Reports::Mortgage < Reports
  protected

  def other_fields
    { address_id: request_payload.id }
  end

  def request_payload
    decision_request.address
  end

  def service
    "ReportService::PropertyDataService"
  end

  def parser
    "ReportParser::Property"
  end

  def report_class
    "MortgageReport"
  end
end
