require "rails_helper"

RSpec.describe RegistrationsController, type: :controller do
  let(:event) { create(:event) }
  let(:user) { create(:user) }
  let(:registration) { create(:registration, event: event, user: user) }

  describe 'POST #create' do
    context 'with valid parameters' do
      before(:each) do
        sign_in user
      end

      it 'returns a successful response' do
        post :create, params: { event_id: event.id }
        expect(response).to redirect_to(events_path)
      end

      it 'creates a new registration' do
        expect {
          post :create, params: { event_id: event.id }
        }.to change(Registration, :count).by(1)
      end
    end

    context 'with invalid parameters' do
      it 'returns a successful response' do
        post :create, params: { event_id: event.id, registration: { user_id: nil } }
        expect(response).to redirect_to(new_user_session_path)
      end

      it 'creates a new registration' do
        expect {
          post :create, params: { event_id: event.id, registration: { user_id: nil }  }
        }.to change(Registration, :count).by(0)
      end
    end
  end

  describe 'DELETE #destroy' do
    before(:each) do
      sign_in user
    end


    it 'deletes the registration' do
      expect {
        delete :destroy, params: { event_id: event.id, id: registration.id }
      }.to change(Registration, :count).by(0)
    end


    it 'redirects to the events  page' do
      delete :destroy, params: { event_id: event.id, id: registration.id  }
      expect(flash[:notice]).to eq('Inscrição cancelada com sucesso!')
    end
  end
end
