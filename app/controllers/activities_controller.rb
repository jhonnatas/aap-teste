class ActivitiesController < ApplicationController
  layout "evento_show", only: [:index, :show ]

  before_action :authenticate_user!, except: %i[index show]
  before_action :load_event


  def index
    @activities = @event.activities.order(period_start: :desc)
  end

  def show
    @activity = Activity.find(params[:id])
  end

  private

  def load_event
    @event = Event.find(params[:event_id])
  end
end
