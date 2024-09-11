class EventsController < ApplicationController
  before_action: load_event, only: [:edit, :show, :update, :destroy]

  def index
    @events = Event.order(period_start: :desc)
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new event_params
    if @event.save
      redirect_to events_path, notice: 'Evento salvo com sucesso'
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def event_params
    params.require(:event).permit(:name, :local, :period_start, :period_end)
  end

  def load_event
    @event = Event.find(params[:id])
  end
end
