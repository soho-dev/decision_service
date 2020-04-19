class Api::V1::DecisionsController < Api::ApiRestrictController
  before_action :build_request!, only: [:create]

  def create
    decision = Processor.new(decision_request).process
    render json: decision
  end

  private

  attr_reader :decision_request

  def build_request!
    @decision_request = RequestBuilder.new(application_id, address_params, applicant_params).decision_request
    render json: { message: "Request not valid"}, status: 422 and return unless decision_request.valid?
  end

  def application_id
    params.permit(:application_id)
  end

  def address_params
    params.require(:address).permit(:street, :unit_number, :city, :zip, :state, :county)
  end

  def applicant_params
    params.permit(:first_name, :last_name, :ssn, :income, :income_type, :requested_loan_amount)
  end
end
