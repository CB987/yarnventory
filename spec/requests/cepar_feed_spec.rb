require 'rails_helper'

RSpec.describe "CeparFeeds", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/cepar_feed/index"
      expect(response).to have_http_status(:success)
    end
  end

end
