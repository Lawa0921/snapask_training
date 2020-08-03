require "rails_helper"
RSpec.feature "Ping", type: :request do
  let (:user) { create(:user) }
  describe "GET /api/v0/ping" do
    context "When successful" do
      before do
        access_key = user.api_access_token
        get "/api/v0/ping", params: { access_key: access_key }
        @result = JSON.parse(response.body)
      end
      it "should be return success" do
        expect(response.status).to eq 200
        expect(@result).to eq "success"
      end
    end
    context "When unfilled access" do
      before do
        get "/api/v0/ping"
        @result = JSON.parse(response.body)
      end
      it "should be raise AuthorizationError" do
        expect(response.status).to eq 401
        expect(@result["error"]["message"]).to eq 'Authorization failed'
      end
    end
  end
end
