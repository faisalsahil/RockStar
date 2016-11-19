class EventsController < ApplicationController
  
  def index
    @active_events    = Event.where('end_date > ?',   Date.today)
    @pending_events   = Event.where('start_date > ?', Date.today)
    @completed_events = Event.where('end_date < ?',   Date.today)
  end
end
