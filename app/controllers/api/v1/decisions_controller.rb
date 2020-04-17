class Api::V1::DecisionsController < Api::ApiRestrictController
  def create
    request = Request.new(application_id, address_params, applicant_params)
    render json: { message: "Request not valid"}, status: 422 and return unless request.valid?
    decision = Processor.new(request.decision_request).process
    render json: decision
  end

  private

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
