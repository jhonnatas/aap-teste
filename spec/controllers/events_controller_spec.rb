require "rails_helper"

RSpec.describe EventsController, type: :controller do
  describe 'GET #index' do
    it 'returns a successful response' do
      get :index
      expect(response).to be_successful
      expect(response).to render_template(:index)
    end

    it 'assigns @events' do
      events = create_list(:event, 3)
      get :index
      expect(assigns(:events)).to_not be_empty
      expect(assigns(:events)).to include(events.first)
    end
  end

  describe 'GET #show' do
    let(:event) { create(:event) }

    it 'returns a successful response' do
      get :show, params: { id: event.id }
      expect(response).to be_successful
    end

    it 'assigns @event' do
      get :show, params: { id: event.id }
      expect(assigns(:event)).to eq(event)
    end

    it 'renders the show template' do
      get :show, params: { id: event.id }
      expect(response).to render_template(:show)
    end
  end
end
