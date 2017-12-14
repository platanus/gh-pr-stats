require 'rails_helper'

RSpec.describe WebhookController, type: :controller do
  describe "GET #index" do
    it "returns json success" do
      get :index
      expect(response).to have_http_status(200)
    end
  end

  describe "POST #receive" do
    it "returns json success" do
      post :receive
      expect(response).to have_http_status(401)
    end
  end
end
