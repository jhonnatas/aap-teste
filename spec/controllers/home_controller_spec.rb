require "rails_helper"

RSpec.describe HomeController, type: :controller do
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
end
