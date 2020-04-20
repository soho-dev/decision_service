require 'rails_helper'

RSpec.describe Api::V1::DecisionsController, type: :controller do
  describe "POST #create" do
    let(:valid_request_data) {
      {
        application_id: 123,
        first_name: "john",
        last_name: "doe",
        date_of_birth: "will_not_be_stored",
        ssn: "123456789",
        email: "aa@aa.com",
        phone: "1234567890",
        income: 10000,
        income_type: "salary",
        requested_loan_amount: 20000,
        address: {
          street: "212 encounter bay",
          unit_number: 123,
          city: "test_city",
          zip: "321",
          state: "test_state",
          county: "test_county"
        }
      }
    }
    let(:rule_config) {
      {
        "enabled" =>  true,
        "mortgage_threshold" => 10,
        "credit_score_threshold" => 1
      }
    }

    it "returns a 401" do
      request.headers["HTTP_API_TOKEN"] = "not_foo"
      post :create, params: valid_request_data
      expect(response.status).to eq(401)
    end

    context "with vaid authentication" do
      before(:each) do
        request.headers["HTTP_API_TOKEN"] = "foo"
      end

      let(:decision) {
        {
          "application_id" => 123,
          "address" => {
            "street" => "212 encounter bay",
            "city" => "test_city",
            "zip" => "321",
            "state" => "test_state",
            "county" => "test_county"
          },
          "applicant" => {
            "first_name" => "john",
            "last_name" => "doe",
            "ssn" => "123456789",
            "income" => 10000.0,
            "requested_loan_amount" => 20000.0,
          },
          "final_decision" => "eligible",
          "decision" => [
            {
              "rule_name" => "mortgage_rule",
              "decision" => "eligible",
              "message" => "The outstanding mortgage loan on the applicants property is checked in relation with his income."
            },
            {
              "rule_name" => "credit_rule",
              "decision" => "eligible",
              "message" => "The credit score of applicant is checked"
            }
          ],
          "funding_options" => [
            {
              "years" => 5,
              "interest_rate" => 6,
              "emi" => 100
            },
            {
              "years" => 10,
              "interest_rate" => 6,
              "emi" => 60
            }
          ]
        }
      }

      it "returns a 200" do
        allow_any_instance_of(::RulesConfig).to receive(:values).and_return(rule_config)
        post :create, params: valid_request_data
        expect(response).to have_http_status(:ok)
      end

      it "returns decision" do
        allow_any_instance_of(::RulesConfig).to receive(:values).and_return(rule_config)
        post :create, params: valid_request_data
        expect(JSON.parse(response.body)).to eq(decision)
      end
    end
  end
end
