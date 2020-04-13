require 'reports'
class Reports::Mortgage < Reports
  protected

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
