class Api::ApiRestrictController < ActionController::API
  before_action :authenticate!

  def authenticate!
    render json: { message: "api token mismatch"}, status: 401 unless api_token == ENV['TOKEN']
  end

  private

  def api_token
    @api_token ||= request.env["HTTP_API_TOKEN"] || params["API_TOKEN"]
  end
end
