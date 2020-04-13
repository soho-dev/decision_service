require 'reports'
class Reports::Mortgage < Reports
  protected
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
