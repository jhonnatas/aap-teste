class ActivityRegistrationsController < ApplicationController
  def register
    @activity = Activity.find(params[:activity_id])
    @activity_registration = @activity.activity_registrations.build(user: current_user)
    @activity_registration.status = :confirmed
    if @activity_registration.save
      redirect_to event_activities_path, notice: 'Inscrição realizada com sucesso.'
    else
      redirect_to @activity, alert: 'Não foi possível realizar a inscrição.'
    end
  end
end
