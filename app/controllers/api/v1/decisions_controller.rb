class Api::V1::DecisionsController < Api::ApiRestrictController
  def index
    head :ok
  end

  def show
    head :ok
  end

  def create
    decision_request = DecisionRequest.new(params)
    render json: { message: "decision request not valid"}, status: 422 unless DecisionRequest.new(params).valid?
    decision = Processer.new(decision_request).process
    render json: decision
  end
end
