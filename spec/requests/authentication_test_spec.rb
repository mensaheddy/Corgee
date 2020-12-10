require 'rails_helper'

RSpec.describe "Authentication request for ocurring properly", type: :request do
  let!(:current_user) { FactoryBot.create(:user) }
  before { sign_in(current_user) }

  describe "Sign in" do

    it "does not login when no data" do
      post user_session_path
      expect(response.status).to eq(401)
    end

    it 'gives you a status 200 on signing in ' do
      post user_session_path, params: { email: current_user.email, password: '12345678', password_confirmation: "12345678"}
      expect(response.status).to eq(200)
    end
  end

  describe "Sign up" do
    let(:params) do
      { email: "john.doe@example.com", last_name: "Doe", first_name: "John", password: "12345678", password_confirmation: "12345678" }
    end

    it "creates a user" do
      expect do
        post user_registration_path, params: params
      end.to change(User, :count).by(1)
    end

    it 'gives you a status 200 on signing in ' do
      post user_registration_path, params: params
      expect(response.status).to eq(200)
    end
  end
end