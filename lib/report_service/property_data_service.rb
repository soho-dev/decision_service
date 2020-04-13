module ReportService
  class PropertyDataService
    def self.call
      JSON.parse(File.read("#{Rails.root}/lib/report_service/sample_data/property.json"))
    end
  end
end
