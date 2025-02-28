class RegistrationsController < ApplicationController
  before_action :authenticate_user!
  def index
    @registrations = current_user.registrations.all
  end

  def create
    @registration = current_user.registrations.new
    @registration.event = Event.find(params[:event_id])
    @registration.status = :confirmed
    if @registration.save
      redirect_to events_path, notice: "Inscrito no evento com sucesso!"
    else
      redirect_to events_path, error: "Não foi possível fazer a inscrição nesse evento"
    end
  end

  def show
    @registration = Registration.find(params[:id])
  end

  def destroy
    @registration = Registration.for_user_and_event(current_user.id, params[:event_id]).first
    @registration.destroy
    redirect_to events_path, notice: "Inscrição cancelada com sucesso!"
  end

  private

  def registration_params
    params.require(:registration).permit(:event_id)
  end
end
