require "rails_helper"

RSpec.describe ActivitiesController, type: :controller do
  let!(:event) { create(:event) }
  let!(:activities) { create_list(:activity, 3, event: event) }

  describe 'GET #index' do
    it 'returns a successful response' do
      get :index, params: { event_id: event.id }
      expect(response).to be_successful
      expect(response).to render_template(:index)
    end

    it 'assigns @activities' do
      get :index, params: { event_id: event.id }
      expect(assigns(:activities)).to include(activities.first)
    end
  end

  describe 'GET #show' do
    it 'returns a successful response' do
      get :show, params: { event_id: event.id, id: activities.first.id }
      expect(response).to be_successful
    end

    it 'assigns @event' do
      get :show, params: { event_id: event.id, id: activities.first.id }
      expect(assigns(:activity)).to eq(activities.first)
    end

    it 'renders the show template' do
      get :show, params: { event_id: event.id, id: activities.first.id }
      expect(response).to render_template(:show)
    end
  end
end
