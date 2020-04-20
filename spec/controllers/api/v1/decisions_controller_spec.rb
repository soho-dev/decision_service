require 'rails_helper'

RSpec.describe Api::V1::DecisionsController, type: :controller do
  describe "POST #create" do
    let(:valid_request_data) {
      {
        application_id: 123,
        first_name: "abba",
        last_name: "dabba",
        date_of_birth: "will_not_be_Stored",
        ssn: "123456789",
        email: "aa@aa.com",
        phone: "1234567890",
        income: 10000,
        income_type: "salary",
        requested_loan_amount: 20000,
        address: {
          street: "123 encounter bay",
          unit_number: 123,
          city: "test_city",
          zip: "321",
          state: "test_state",
          county: "test_county"
        }
      }
    }

    it "returns a 401" do
      request.headers["API_TOKEN"] = "not_foo"
      post :create, params: valid_request_data
      expect(response.status).to eq(401)
    end

    context "with vaid authentication" do
      before(:each) do
        request.headers["API_TOKEN"] = "foo"
      end

      let(:decision) {
        {
          application_id: 123,
          address: {
            street: "123",
            city: "test_city",
            zip: "321",
            state: "test_state",
            county: "test_county"
          },
          applicant: {
            first_name: "abba",
            last_name: "dabba",
            ssn: "123456789",
            income: 10000,
            requested_loan_amount: "20000",
          },
          final_decision: "eligible",
          decision: [
            {
              rule_name: "credit_rule",
              decision: "eligible",
              reason: "eligible"
            },
            {
              rule_name: "mortgage_rule",
              decision: "decline",
              reason: "mortgage above threshold of 5"
            }
          ],
          funding_options: [
            {
              years: 5,
              interest_rate: 6,
              emi: 100
            },
            {
              years: 10,
              interest_rate: 6,
              emi: 60
            }
          ]
        }
      }

      it "returns a 200" do
        post :create, params: valid_request_data
        expect(response).to have_http_status(:ok)
      end

      it "returns decision" do
        post :create, params: valid_request_data
        expect(response).to eq(decision)
      end
    end
  end
end
