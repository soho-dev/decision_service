require 'rails_helper'

RSpec.describe Api::V1::DecisionsController, type: :controller do
  describe "GET #index" do
    it "returns a 200" do
      request.headers["API_TOKEN"] = "foo"
      get :index
      expect(response).to have_http_status(:ok)
    end
  end
end
