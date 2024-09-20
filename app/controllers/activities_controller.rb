class ActivitiesController < ApplicationController
  layout "evento_show", only: [ :index, :show ]

  PERMITED_PARAMS = [
    :name, :local, :period_start, :period_end, :title, :speaker,
    :certificate_hours, :subscriptions_open ].freeze

  before_action :authenticate_user!, except: %i[index show]
  before_action :load_event
  before_action :load_activity, only: %i[ edit show update destroy]


  def index
    @activities = @event.activities.order(period_start: :desc)
  end

  def show;end
  def edit
    authorize @activity
  end

  def new
    @activity = @event.activities.build
    authorize @activity
  end

  def create
    @activity = @event.activities.build activity_params
    if @activity.save
      redirect_to event_activities_path, notice: "Atividade cadastrada com sucesso!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @activity.update activity_params
      authorize @activity
      redirect_to event_activities_path, notice: "Atividade atualizada com sucesso!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @activity
    @activity.destroy
    redirect_to event_activities_path, notice: "Atividade Excluida com sucesso!"
  end

  private

  def load_event
    @event = Event.find(params[:event_id])
  end

  def load_activity
    @activity = @event.activities.find(params[:id])
  end

  def activity_params
    params.require(:activity).permit(*PERMITED_PARAMS)
  end
end
