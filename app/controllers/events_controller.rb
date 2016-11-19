class EventsController < ApplicationController
  
  def index
    @active_events    = Event.where('end_date > ?',   Date.today)
    @pending_events   = Event.where('start_date > ?', Date.today)
    @completed_events = Event.where('end_date < ?',   Date.today)
  end
  
  def show
    @event            = Event.find_by_id(params[:id])
    @event_detail    = @event.event_detail
    @event_hall       = @event.event_hall
    @event_bands      = @event.bands
    @event_organizers = @event.back_stage_members
  end
end
