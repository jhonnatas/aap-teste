module Admin
  class DashboardController < BaseController
    def index
      @events = Event.all
    end
  end
end
