module ReportService
  class PropertyDataService
    def self.call(address)
      mock_data = JSON.parse(File.read("#{Rails.root}/lib/report_service/sample_data/property.json"))
      mock_data[address.street]
    end
  end
end
