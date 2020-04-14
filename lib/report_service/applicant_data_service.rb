module ReportService
  class ReportNotFound < StandardError; end
  class ApplicantDataService
    def self.call(applicant)
      mock_data = JSON.parse(File.read("#{Rails.root}/lib/report_service/sample_data/applicant.json"))
      applicant_report = mock_data[applicant.ssn]
      raise ReportService::ReportNotFound if applicant_report.nil?
      applicant_report
    end
  end
end
