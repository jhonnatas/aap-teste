class HomeController < ApplicationController
  before_action :authenticate_user!, except: :index
  def index
    @events = Event.order(period_start: :desc).limit(5)
  end
end
