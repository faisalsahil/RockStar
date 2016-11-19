class EventsController < ApplicationController
  
  def index
    @active_events    = Event.where('end_date > ?',   Date.today)
    @pending_events   = Event.where('start_date > ?', Date.today)
    @completed_events = Event.where('end_date < ?',   Date.today)
  end
  
  def show
    @event            = Event.find_by_id(params[:id])
    @event_detail    = @event.try(:event_detail)
    @event_hall       = @event.try(:event_hall)
    @event_bands      = @event.try(:bands)
    @event_organizers = @event.try(:back_stage_members)
  end
end
