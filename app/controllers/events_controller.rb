class EventsController < ApplicationController
  PERMITED_PARAMS = [
    :name, :local, :period_start, :period_end, :email, :responsable,
    :txtEnter, :txtAbout, :comission, :primaryColor,
    :secondaryColor, :status, :banner ].freeze

  layout "evento_show", only: [ :show ]

  before_action :authenticate_user!, except: %i[index show]
  before_action :load_event, only: [ :edit, :show, :update, :destroy ]

  def index
    @events = Event.order(period_start: :desc)
    @registration = current_user.registrations.new if current_user
  end

  def new
    @event = current_user.events.build
  end

  def create
    @event = current_user.events.build event_params
    if @event.save
      current_user.role = :manager unless current_user.admin?
      redirect_to events_path, notice: "Evento salvo com sucesso"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    authorize @event
    if @event.update event_params
      #      current_user.role = :manager unless current_user.admin?
      redirect_to events_path, notice: "Evento atualizado com sucesso"
    else
      render :edit, status: :unprocessable_entity
    end
  end


  def show;end

  def edit
    authorize @event
  end

  def destroy
    authorize @event
    @event.destroy
    redirect_to events_path, notice: "Evento excluido com sucesso"
  end

  private

  def event_params
    params.require(:event).permit(*PERMITED_PARAMS)
  end

  def load_event
    @event = Event.find(params[:id])
  end
end
