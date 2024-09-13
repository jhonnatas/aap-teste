class EventsController < ApplicationController
  PERMITED_PARAMS = [
    :name, :local, :period_start, :email, :responsable,
    :txtEnter, :txtAbout, :comission, :primaryColor,
    :secondaryColor, :status ].freeze

  before_action :authenticate_user!
  before_action :load_event, only: [:edit, :show, :update, :destroy]

  def index
    @events = Event.order(period_start: :desc)
  end

  def new
    @event = current_user.events.new
  end

  def create
    @event = current_user.events.new event_params
    if @event.save
      redirect_to events_path, notice: 'Evento salvo com sucesso'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if current_user.events.update event_params
      redirect_to events_path, notice: 'Evento atualizado com sucesso'
    else
      render :new, status: :unprocessable_entity
    end
  end


  def show;end

  def edit;end

  def destroy
    @event.destroy
    redirect_to events_path, notice: 'Evento excluido com sucesso'
  end

  private

  def event_params
    params.require(:event).permit(*PERMITED_PARAMS)
  end

  def load_event
    @event = Event.find(params[:id])
  end
end
