require 'rails_helper'

RSpec.describe Api::V1::DecisionsController, type: :controller do
  describe "GET #index" do
    it "returns a 200" do
      request.headers["API_TOKEN"] = "foo"
      get :index
      expect(response).to have_http_status(:ok)
    end

    it "returns a 401" do
      request.headers["API_TOKEN"] = "not_foo"
      get :index
      expect(response.status).to eq(401)
    end
  end
end
