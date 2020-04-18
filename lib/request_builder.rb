class RequestBuilder
  attr_accessor :decision_request, :applicant, :address

  def valid?
    valid
  end

  private

  attr_accessor :application_id, :address_params, :applicant_params, :valid

  def initialize(application_id, address_params, applicant_params)
    @application_id = application_id
    @address_params = address_params
    @applicant_params = applicant_params
    @valid = false
    create_decision_request
  end

  def create_decision_request
    ActiveRecord::Base.transaction do
      @decision_request = DecisionRequest.create(application_id)
      @address = @decision_request.create_address(address_params)
      @applicant = @decision_request.create_applicant(applicant_params)
      @valid = true
    end
  rescue
    @valid = false
  end
end
