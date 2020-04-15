module ReportService
  class ReportNotFound < StandardError; end

  class PropertyDataService
    def self.call(address)
      mock_data = JSON.parse(File.read("#{Rails.root}/lib/report_service/sample_data/property.json"))
      property_report = mock_data[address.street.downcase.parameterize.underscore] rescue nil
      raise ReportService::ReportNotFound if property_report.nil?
      property_report
    end
  end
end
