require 'rails_helper'

RSpec.describe Api::V1::DecisionsController, type: :controller do
  describe "GET #index" do
    it "returns a 401" do
      request.headers["API_TOKEN"] = "not_foo"
      get :index
      expect(response.status).to eq(401)
    end

    context "with vaid authentication" do
      before(:each) do
        request.headers["API_TOKEN"] = "foo"
      end

      it "returns a 200" do
        get :index
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe "GET #create" do
    it "returns a 401" do
      request.headers["API_TOKEN"] = "not_foo"
      get :create
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
            salary: "10000"
          },
          loan_amt: "20000",
          decision: "eligible",
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
        get :create
        expect(response).to have_http_status(:ok)
      end

      it "returns decision" do
        get :create
        expect(response).to eq(decision)
      end
    end
  end

  describe "GET #show" do
    it "returns a 401" do
      request.headers["API_TOKEN"] = "not_foo"
      get :show, params: { id: 1 }
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
            salary: "10000"
          },
          loan_amt: "20000",
          decision: "eligible",
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
        get :show, params: { id: 1 }
        expect(response).to have_http_status(:ok)
      end

      it "returns decision" do
        get :show, params: { id: 1 }
        expect(response).to eq(decision)
      end
    end
  end
end
