require "rails_helper"

RSpec.describe Admin::ActivitiesController, type: :controller do
  let!(:event) { create(:event) }
  let!(:activity) { create(:activity, event: event) }

  describe 'GET #show' do
    context 'without authentication' do
      it "returns a login page response" do
        get :show, params: { event_id: event.id, id: activity.id }
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context 'with authentication' do
      before(:each) do
        sign_in create(:user)
      end
      it 'returns a successful response' do
        get :show, params: { event_id: event.id, id: activity.id }
        expect(response).to be_successful
      end

      it 'assigns @event' do
        get :show, params: { event_id: event.id, id: activity.id }
        expect(assigns(:activity)).to eq(activity)
      end

      it 'render a template' do
        get :show, params: { event_id: event.id, id: activity.id }
        expect(assigns(:activity)).to render_template(:show)
      end
    end
  end

  describe 'GET #new' do
    let(:event) { create(:event) }
    let(:activity_params) { attributes_for(:activity, event: event) }

    context 'without authentication' do
      it "returns a login page response" do
        get :new, params: { event_id: event.id, activity: activity_params }
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context 'with authentication' do
      before(:each) do
        sign_in create(:user)
      end

      it 'returns a not authorized message' do
        get :new, params:  { event_id: event.id, activity: activity_params }
        expect(flash[:alert]).to eq('Você não tem autorização para essa ação')
      end

      it 'returns a redirect response' do
        get :new, params:  { event_id: event.id, activity: activity_params }
        expect(response).to redirect_to(root_path)
      end
    end

    context('with authentication and authorization') do
      before(:each) do
        sign_in create(:user, role: 'admin')
      end

      it 'returns a successful response' do
        get :new, params:  { event_id: event.id, activity: activity_params }
        expect(response).to be_successful
      end

      it 'assigns @activity' do
        get :new, params:  { event_id: event.id, activity: activity_params }
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'POST #create' do
    let(:event) { create(:event) }
    let(:activity_params) { attributes_for(:activity, event: event) }

    context 'without authentication' do
      it "returns a login page response" do
        post :create, params: { event_id: event.id, activity: activity_params }
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context 'with authentication' do
      before(:each) do
        sign_in create(:user)
      end

      it 'returns a not authorized message' do
        post :create, params: { event_id: event.id, activity: activity_params }
        expect(flash[:alert]).to eq("Você não tem autorização para essa ação")
      end

      it 'returns a redirect response' do
        post :create, params: { event_id: event.id, activity: activity_params }
        expect(response).to redirect_to(root_path)
      end
    end

    context('with authentication and authorization') do
      before(:each) do
        sign_in create(:user, role: 'admin')
      end

      it 'returns a successful response' do
        post :create, params: { event_id: event.id, activity: activity_params }
        expect(response).to redirect_to(admin_event_path(event))
      end

      it 'returns an authorized message' do
        post :create, params: { event_id: event.id, activity: activity_params }
        expect(flash[:notice]).to eq("Atividade cadastrada com sucesso!")
      end

      it 'creates a valid activity' do
        expect {
          post :create, params: { event_id: event.id, activity: activity_params }
        }.to change(Activity, :count).by(1)
      end
    end
  end

  describe 'GET #edit' do
    let(:event) { create(:event) }
    let(:activity) { create(:activity, event: event) }

    context 'without authentication' do
      it "returns a login page response" do
        get :edit, params: { event_id: event.id, id: activity.id }
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context 'with authentication' do
      before(:each) do
        sign_in create(:user)
      end

      it 'returns a not authorized message' do
        get :edit, params: { event_id: event.id, id: activity.id }
        expect(flash[:alert]).to eq("Você não tem autorização para essa ação")
      end

      it 'returns a redirect response' do
        get :edit, params: { event_id: event.id, id: activity.id }
        expect(response).to redirect_to(root_path)
      end
    end

    context('with authentication and authorization') do
      before(:each) do
        sign_in create(:user, role: 'admin')
      end

      it 'returns a successful response' do
        get :edit, params: { event_id: event.id, id: activity.id }
        expect(response).to be_successful
      end

      it 'assigns @activity' do
        get :edit, params: { event_id: event.id, id: activity.id }
        expect(assigns(:activity)).to eq(activity)
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'PUT #update' do
    let(:event) { create(:event) }
    let(:activity) { create(:activity, event: event) }
    let(:activity_params) { attributes_for(:activity, event: event) }

    context 'without authentication' do
      it "returns a login page response" do
        put :update, params: { event_id: event.id, id: activity.id, activity: activity_params }
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context 'with authentication' do
      before(:each) do
        sign_in create(:user)
      end

      it 'returns a not authorized message' do
        put :update, params: { event_id: event.id, id: activity.id, activity: activity_params }
        expect(flash[:alert]).to eq("Você não tem autorização para essa ação")
      end

      it 'returns a redirect response' do
        put :update, params: { event_id: event.id, id: activity.id, activity: activity_params }
        expect(response).to redirect_to(root_path)
      end
    end

    context('with authentication and authorization') do
      before(:each) do
        sign_in create(:user, role: 'admin')
      end

      it 'returns a successful response' do
        put :update, params: { event_id: event.id, id: activity.id, activity: activity_params }
        expect(response).to redirect_to(admin_event_path(event))
      end

      it 'returns an authorized message' do
        put :update, params: { event_id: event.id, id: activity.id, activity: activity_params }
        expect(flash[:notice]).to eq("Atividade atualizada com sucesso!")
      end

      it 'updates a valid activity' do
        put :update, params: { event_id: event.id, id: activity.id, activity: activity_params }
        expect(response).to redirect_to(admin_event_path(event))
      end
    end
  end

  describe 'DELETE #destroy' do
    let(:event) { create(:event) }
    let(:activity) { create(:activity, event: event) }

    context 'without authentication' do
      it "returns a login page response" do
        delete :destroy, params: { event_id: event.id, id: activity.id }
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context 'with authentication' do
      before(:each) do
        sign_in create(:user)
      end

      it 'returns a not authorized message' do
        delete :destroy, params: { event_id: event.id, id: activity.id }
        expect(flash[:alert]).to eq("Você não tem autorização para essa ação")
      end

      it 'returns a redirect response' do
        delete :destroy, params: { event_id: event.id, id: activity.id }
        expect(response).to redirect_to(root_path)
      end
    end

    context('with authentication and authorization') do
      before(:each) do
        sign_in create(:user, role: 'admin')
      end

      it 'returns a successful response' do
        delete :destroy, params: { event_id: event.id, id: activity.id }
        expect(response).to redirect_to(admin_event_path(event))
      end

      it 'returns a successfully deleted message' do
        delete :destroy, params: { event_id: event.id, id: activity.id }
        expect(response).to redirect_to(admin_event_path(event))
        expect(Activity.find_by(id: activity.id)).to be_nil
        expect(flash[:notice]).to eq("Atividade Excluida com sucesso!")
      end
    end
  end
end
