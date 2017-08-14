class EventsController < ApplicationController
  def create
    render :json => {:error => 'nope'}
  end

  def event_params
    params.require(:pusher_event).permit(:name, :message, :broadcast)
  end
end
