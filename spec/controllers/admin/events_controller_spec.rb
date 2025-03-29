require "rails_helper"

module Admin
  RSpec.describe EventsController, type: :controller do
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
      let(:event) { create(:event) }  # Define a factory for the Event model

      context 'without authentication' do
        it "returns a login page response" do
          get :show, params: { id: event.id }
          expect(response).to redirect_to(new_user_session_path)
        end
      end

      context 'with authentication' do
        before(:each) do
          sign_in create(:user)
        end
        it 'returns a successful response' do
          get :show, params: { id: event.id }
          expect(response).to be_successful
        end
        it 'assigns @event' do
          get :show, params: { id: event.id }
          expect(assigns(:event)).to eq(event)
        end
      end
    end

    describe 'GET #new' do
      let(:event_params) { attributes_for(:event) }

      context 'without authentication' do
        it "returns a login page response" do
          get :new
          expect(response).to redirect_to(new_user_session_path)
        end
      end

      context 'with authentication' do
        before(:each) do  # Define a factory for the Event model
          sign_in create(:user)
        end

        it 'returns a not authorized message' do
          get :new, params: { event: event_params }
          expect(flash[:alert]).to eq('Você não tem autorização para essa ação')
        end

        it 'returns a redirect response' do
          get :new, params: { event: event_params }
          expect(response).to redirect_to(root_path)
        end
      end

      context('with authentication and authorization') do
        before(:each) do  # Define a factory for the Event model
          sign_in create(:user, role: 'admin')
        end

        it 'returns a successful response' do
          get :new, params: { event: event_params }
          expect(response).to be_successful
          expect(response).to render_template(:new)
        end
      end
    end

    describe 'POST #create' do
      let(:event_params) { attributes_for(:event) }

      context 'without authentication' do
        it "returns a login page response" do
          post :create, params: { event: event_params }
          expect(response).to redirect_to(new_user_session_path)
        end
      end

      context 'with authentication' do
        before(:each) do  # Define a factory for the Event model
          sign_in create(:user)
        end

        it 'returns a redirect response' do
          post :create, params: { event: event_params }
          expect(response).to redirect_to(root_path)
        end

        it 'returns a not authorized message' do
          post :create, params: { event: event_params }
          expect(flash[:alert]).to eq('Você não tem autorização para essa ação')
        end
      end

      context('with authentication and authorization') do
        before(:each) do  # Define a factory for the Event model
          sign_in create(:user, role: 'admin')
        end

        it 'returns a successful response' do
          post :create, params: { event: event_params }
          expect(response).to redirect_to(admin_events_path)
        end

        it 'returns a not authorized message' do
          post :create, params: { event: event_params }
          expect(flash[:notice]).to eq("Evento salvo com sucesso")
        end

        it 'creates a valid event' do
          expect {
            post :create, params: { event: event_params }
          }.to change(Event, :count).by(1)
        end
      end
    end

    describe 'GET #edit' do
      let(:event) { create(:event) }  # Define a factory for the Event model
      let(:event_params) { attributes_for(:event) }

      context 'without authentication' do
        it "returns a login page response" do
          get :edit, params: { id: event.id }
          expect(response).to redirect_to(new_user_session_path)
        end
      end

      context 'with authentication' do
        before(:each) do  # Define a factory for the Event model
          sign_in create(:user)
        end

        it 'returns a redirect response' do
          get :edit, params: { id: event.id }
          expect(response).to redirect_to(root_path)
        end

        it 'returns a not authorized message' do
          get :edit, params: { id: event.id }
          expect(flash[:alert]).to eq("Você não tem autorização para essa ação")
        end
      end

      context('with authentication and authorization') do
        before(:each) do  # Define a factory for the Event model
          sign_in create(:user, role: 'admin')
        end

        it 'returns a successful response' do
          get :edit, params: { id: event.id }
          expect(response).to be_successful
          expect(response).to render_template(:edit)
        end
      end
    end

    describe 'PUT #update' do
      let(:event) { create(:event) }  # Define a factory for the Event model
      let(:event_params) { attributes_for(:event) }

      context 'without authentication' do
        it "returns a login page response" do
          put :update, params: { id: event.id, event: event_params }
          expect(response).to redirect_to(new_user_session_path)
        end
      end

      context 'with authentication' do
        before(:each) do  # Define a factory for the Event model
          sign_in create(:user)
        end

        it 'returns a redirect response' do
          put :update, params: { id: event.id, event: event_params }
          expect(response).to redirect_to(root_path)
        end

        it 'returns a not authorized message' do
          put :update, params: { id: event.id, event: event_params }
          expect(flash[:alert]).to eq("Você não tem autorização para essa ação")
        end
      end

      context('with authentication and authorization') do
        before(:each) do  # Define a factory for the Event model
          sign_in create(:user, role: 'admin')
        end

        it 'returns a successful response' do
          put :update, params: { id: event.id, event: event_params }
          expect(response).to redirect_to(admin_events_path)
        end

        it 'returns a successfully updated message' do
          put :update, params: { id: event.id, event: event_params }
          expect(response).to redirect_to(admin_events_path)
          expect(event.reload.name).to eq(event_params[:name])
          expect(flash[:notice]).to eq("Evento atualizado com sucesso")
        end
      end
    end

    describe 'DELETE #destroy' do
      let(:event) { create(:event) }  # Define a factory for the Event model

      context 'without authentication' do
        it "returns a login page response" do
          delete :destroy, params: { id: event.id }
          expect(response).to redirect_to(new_user_session_path)
        end
      end

      context 'with authentication' do
        before(:each) do  # Define a factory for the Event model
          sign_in create(:user)
        end

        it 'returns a redirect response' do
          delete :destroy, params: { id: event.id }
          expect(response).to redirect_to(root_path)
        end

        it 'returns a not authorized message' do
          delete :destroy, params: { id: event.id }
          expect(flash[:alert]).to eq("Você não tem autorização para essa ação")
        end
      end

      context('with authentication and authorization') do
        before(:each) do  # Define a factory for the Event model
          sign_in create(:user, role: 'admin')
        end

        it 'returns a successful response' do
          delete :destroy, params: { id: event.id }
          expect(response).to redirect_to(admin_events_path)
        end

        it 'returns a successfully deleted message' do
          delete :destroy, params: { id: event.id }
          expect(response).to redirect_to(admin_events_path)
          expect(Event.find_by(id: event.id)).to be_nil
          expect(flash[:notice]).to eq("Evento excluido com sucesso")
        end

        it 'destroys an event' do
          expect {
            delete :destroy, params: { id: event.id }
          }.to change(Event, :count).by(0)
        end
      end
    end
  end
end
