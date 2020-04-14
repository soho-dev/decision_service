class Api::V1::DecisionsController < Api::ApiRestrictController
  def index
    head :ok
  end

  def show
    head :ok
  end

  def create
    # decision_request = DecisionRequestFilter.new(application_id, address_params, applicant_params)
    # render json: { message: "decision request not valid"}, status: 422 unless decision_request.valid?
    # decision = Processor.new(decision_request.decision_request).process
    # render json: decision.serialize
    render json: {
      "application_id": 123,
        "address": {
            "street": "123 encounter bay",
            "city": "test_city",
            "zip": "321",
            "state": "test_state",
            "county": "test_county"
        },
        "applicant": {
            "first_name": "abba",
            "last_name": "dabba",
            "ssn": "123456789",
            "income": 10000.0,
            "requested_loan_amount": 20000.0
        },
        "final_decision": "eligible",
        "decision": [
            {
                "rule_name": "mortgage_rule",
                "decision": "eligible",
                "message": nil
            }
        ],
        "funding_options": [
            {
                "years": 5,
                "interest_rate": 6,
                "emi": 100
            },
            {
                "years": 10,
                "interest_rate": 6,
                "emi": 60
            }
        ]
    }
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
