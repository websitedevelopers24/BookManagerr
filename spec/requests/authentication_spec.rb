require 'rails_helper'

RSpec.describe "Authentication", type: :request do
  let(:user) { User.create!(email: 'user@example.com', password: 'password') }

  describe "POST /users/sign_in" do
    it "logs the user in with valid credentials" do
      post user_session_path, params: { user: { email: user.email, password: user.password } }
      expect(response).to redirect_to(root_path)
      follow_redirect!
      expect(response.body).to include('Signed in successfully.')
    end

    it "does not log the user in with invalid credentials" do
      post user_session_path, params: { user: { email: user.email, password: 'wrongpassword' } }
      expect(response).to render_template(:new)
      expect(response.body).to include('Invalid Email or password.')
    end
  end

  describe "DELETE /users/sign_out" do
    before do
      sign_in user
    end

    it "logs the user out" do
      delete destroy_user_session_path
      expect(response).to redirect_to(root_path)
      follow_redirect!
      expect(response.body).to include('Signed out successfully.')
    end
  end
end
