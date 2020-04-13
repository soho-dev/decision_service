class Api::V1::DecisionsController < Api::ApiRestrictController
  def index
    head :ok
  end

  def show
    head :ok
  end

  def create
    decision_request = DecisionRequestFilter.new(application_id, address_params, applicant_params)
    render json: { message: "decision request not valid"}, status: 422 unless decision_request.valid?
    decision = ::Processer.new(decision_request.decision_request).process
    render json: decision.serialize
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
