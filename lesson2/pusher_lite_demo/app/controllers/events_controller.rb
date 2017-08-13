class EventsController < ApplicationController
  def create
    # SendEventsJob.perform_later(event_params)
    render :json => {:error => 'nope'}
  end

  def event_params
    params.require(:pusher_event).permit(:name, :message, :broadcast)
  end
end
