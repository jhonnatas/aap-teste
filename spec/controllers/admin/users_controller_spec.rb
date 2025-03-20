require "rails_helper"

module Admin
  RSpec.describe UsersController, type: :controller do
    describe "GET #index" do
      context 'without authentication' do
        it "returns a login page response" do
          get :index
          expect(response).to redirect_to(new_user_session_path)
        end
      end

      context 'with authentication' do
        before(:each) do
          sign_in create(:user)
        end

        it "returns a successful response" do
          get :index
          expect(response).to be_successful
          expect(response).to render_template(:index)
        end
      end
    end
  end
end
