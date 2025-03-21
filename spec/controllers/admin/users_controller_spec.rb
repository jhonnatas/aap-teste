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

    describe 'GET #show' do
      let(:user) { create(:user) }

      context 'without authentication' do
        it "returns a login page response" do
          get :show, params: { id: user.id }
          expect(response).to redirect_to(new_user_session_path)
        end
      end

      context 'with authentication' do
        before(:each) do
          sign_in user
        end

        it "returns a successful response" do
          get :show, params: { id: user.id }
          expect(response).to be_successful
          expect(response).to render_template(:show)
        end
      end
    end

    describe 'get #new' do
      let(:user) { create(:user) }
      let(:admin_user) { create(:user, role: 'admin') }
      let(:user_params) { { user: { name: 'John Doe', email: 'HtBz9@example.com', password: 'password', password_confirmation: 'password' } } }

      context 'without authentication' do
        it "returns a login page response" do
          get :new
          expect(response).to redirect_to(new_user_session_path)
        end
      end

      context 'with authentication but not authorized' do
        before(:each) do
          sign_in create(:user)
        end

        it "returns an unauthorized response" do
          get :new, params: user_params
          expect(response).to redirect_to(root_path)
        end

        it "returns an unauthorized message" do
          get :new, params: user_params
          expect(flash[:alert]).to eq('Você não tem autorização para essa ação')
        end
      end

      context 'with authentication and authorization' do
        before(:each) do
          sign_in admin_user
        end

        it "returns a successful response" do
          get :new, params: user_params
          expect(response).to be_successful
        end

        it "returns a template for new" do
          get :new, params: user_params
          expect(response).to render_template(:new)
        end
      end
    end

    describe 'POST #create' do
      let(:user) { create(:user) }  # Supondo que vocé tenha um modelo User
      let(:admin_user) { create(:user, role: 'admin') }
      context 'without authentication' do
        it "returns a login page response" do
          post :create
          expect(response).to redirect_to(new_user_session_path)
        end
      end

      context 'with authentication but not authorized' do
        let(:user_params) { { user: { name: 'John Doe', email: 'HtBz9@example.com', password: 'password', password_confirmation: 'password' } } }
        before(:each) do
          sign_in user
        end

        it "returns an unauthorized response" do
          post :create, params: user_params
          expect(response).to redirect_to(root_path)
        end

        it "returns an unauthorized message" do
          post :create, params: user_params
          expect(flash[:alert]).to eq('Você não tem autorização para essa ação')
        end
      end

      context 'with authentication and authorization' do
        let(:user_params) { { user: { name: 'John Doe', email: 'HtBz9@example.com', password: 'password', password_confirmation: 'password' } } }

        before(:each) do
          sign_in admin_user
        end

        it "returns a successful response" do
          post :create, params: user_params
          expect(response).to redirect_to(admin_users_path)
        end

        it "returns a successfully created message" do
          post :create, params: user_params
          expect(flash[:notice]).to eq("Usuário cadastrado com sucesso!")
        end

        it 'creates a valid user' do
          expect {
            post :create, params: user_params
          }.to change(User, :count).by(1)
        end
      end
    end

    describe 'get #edit' do
      let(:user) { create(:user) }
      let(:admin_user) { create(:user, role: 'admin') }
      let(:user_params) { { user: { name: 'John Doe', email: 'HtBz9@example.com', password: 'password', password_confirmation: 'password' } } }

      context 'without authentication' do
        it "returns a login page response" do
          get :edit, params: { id: user.id }
          expect(response).to redirect_to(new_user_session_path)
        end
      end

      context 'with authentication but not authorized' do
        before(:each) do
          sign_in create(:user)
        end

        it "returns an unauthorized response" do
          get :edit, params: { id: admin_user.id }
          expect(response).to redirect_to(root_path)
        end

        it "returns an unauthorized message" do
          get :edit, params: { id: admin_user.id }
          expect(flash[:alert]).to eq('Você não tem autorização para essa ação')
        end
      end

      context 'with authentication and authorization' do
        before(:each) do
          sign_in admin_user
        end

        it "returns a successful response" do
          get :edit, params: { id: user.id }
          expect(response).to be_successful
        end

        it "returns a template for edit" do
          get :edit, params: { id: user.id }
          expect(response).to render_template(:edit)
        end
      end
    end

    describe 'PUT #update' do
      let(:user) { create(:user, role: 'registered') }
      let(:admin_user) { create(:user, role: 'admin') }
      let(:user_params) { { user: { name: 'John Doe', email: 'HtBz9@example.com', password: 'password', password_confirmation: 'password' } } }

      context 'without authentication' do
        it "returns a login page response" do
          put :update, params: { id: user.id, user: user_params[:user] }
          expect(response).to redirect_to(new_user_session_path)
        end
      end

      context 'with authentication but not authorized' do
        before(:each) do
          sign_in user
        end

        it "returns a unauthorized response" do
          put :update, params: { id: admin_user.id, user: user_params[:user_params] }
          expect(response).to redirect_to(root_path)
        end

        it "returns a unauthorized message" do
          put :update, params: { id: admin_user.id, user: user_params[:user_params] }
          expect(flash[:alert]).to eq('Você não tem autorização para essa ação')
        end
      end

      context 'with authentication and authorization' do
        before(:each) do
          sign_in admin_user
        end

        it "returns a successful response" do
          put :update, params: { id: user.id, user: user_params }
          expect(response).to redirect_to(admin_users_path)
        end

        it "returns a successfully updated message" do
          put :update, params: { id: user.id, user: user_params }
          expect(flash[:notice]).to eq("Usuário atualizado com sucesso!")
        end
      end
    end

    describe 'DELETE #destroy' do
      let(:user) { create(:user) }
      let(:admin_user) { create(:user, role: 'admin') }

      context 'without authentication' do
        it "returns a login page response" do
          delete :destroy, params: { id: user.id }
          expect(response).to redirect_to(new_user_session_path)
        end
      end

      context 'with authentication but not authorized' do
        before(:each) do
          sign_in user
        end

        it "returns an unauthorized response" do
          delete :destroy, params: { id: admin_user.id }
          expect(response).to redirect_to(root_path)
        end

        it "returns an unauthorized message" do
          delete :destroy, params: { id: admin_user.id }
          expect(flash[:alert]).to eq("Você não tem autorização para essa ação")
        end
      end

      context 'with authentication and authorization' do
        before(:each) do
          sign_in admin_user
        end

        it "returns a successful response" do
          delete :destroy, params: { id: user.id }
          expect(response).to redirect_to(admin_users_path)
        end

        it "returns a successfully deleted message" do
          delete :destroy, params: { id: user.id }
          expect(flash[:notice]).to eq("Usuário excluido com sucesso!")
        end

        it 'destroys an user' do
          expect {
            delete :destroy, params: { id: user.id }
          }.to change(User, :count).by(0)
        end
      end
    end
  end
end
