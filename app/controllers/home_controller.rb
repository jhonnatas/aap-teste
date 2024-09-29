class HomeController < ApplicationController
  def index
    @events = Event.order(period_start: :desc).limit(6)
  end
end
