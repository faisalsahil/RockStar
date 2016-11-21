class Event < ApplicationRecord
  @@limit = 10
  
  belongs_to :user
  has_one    :event_detail,        dependent: :destroy
  has_one    :event_hall,          dependent: :destroy
  has_many   :bands,               dependent: :destroy
  has_many   :back_stage_members,  dependent: :destroy
  
  accepts_nested_attributes_for :event_detail, :event_hall, :bands, :back_stage_members
                                
                                
  def self.create_event(current_user, data)
    begin
      data  = data.with_indifferent_access
      event = current_user.events.build(data[:event])
      if event.save
        resp_data    = event_response(event)
        resp_status  = 1
        resp_message = 'Event created'
        resp_errors  = ''
      else
        resp_data    = {}
        resp_status  = 0
        resp_message = 'Errors'
        resp_errors  = event.errors.messages
      end
    rescue Exception => e
      resp_data       = {}
      resp_status     = 0
      resp_message    = 'error'
      resp_errors     = e
    end
    JsonBuilder.json_builder(resp_data, resp_status, resp_message, errors: resp_errors)
  end
  
  def self.event_list(current_user, data)
    begin
      data     = data.with_indifferent_access
      per_page = (data[:per_page] || @@limit).to_i
      page     = (data[:page] || 1).to_i
      if data[:last_event_date].present?
        events = Event.where('created_at > ?', data[:last_event_date]).order('created_at DESC')
      else
        events   = Event.all.order('created_at DESC')
      end
      if events.present?
        events       = events.page(page.to_i).per_page(per_page.to_i)
        paging_data  = JsonBuilder.get_paging_data(page, per_page, events)
        resp_data    = events_response(events)
        resp_status  = 1
        resp_message = 'Events list.'
        resp_errors  = ''
      else
        resp_data    = {}
        resp_status  = 0
        resp_message = 'No event found.'
        resp_errors  = ''
        paging_data  = ''
      end
    rescue Exception => e
      resp_data       = {}
      resp_status     = 0
      resp_message    = 'error'
      resp_errors     = e
      paging_data     = ''
    end
    JsonBuilder.json_builder(resp_data, resp_status, resp_message, errors: resp_errors, paging_data: paging_data)
  end
  
  def self.show_event(current_user, data)
    begin
      data   = data.with_indifferent_access
      event  = Event.find_by_id(data[:id])
      if event.present?
        resp_data    = event_response(event)
        resp_status  = 1
        resp_message = 'Event detail'
        resp_errors  = ''
      else
        resp_data    = {}
        resp_status  = 0
        resp_message = 'Errors'
        resp_errors  = 'Event not found.'
      end
    rescue Exception => e
      resp_data       = {}
      resp_status     = 0
      resp_message    = 'error'
      resp_errors     = e
    end
    JsonBuilder.json_builder(resp_data, resp_status, resp_message, errors: resp_errors)
  end
  
  def self.off_sync(current_user, data)
    begin
      data  = data.with_indifferent_access
      events = []
      data[:event].each do |event|
        event = current_user.events.build(event)
        event.save!
      end
      resp_data    = {}
      resp_status  = 1
      resp_message = 'Off sync success'
      resp_errors  = ''
    rescue Exception => e
      resp_data       = {}
      resp_status     = 0
      resp_message    = 'error'
      resp_errors     = e
    end
    JsonBuilder.json_builder(resp_data, resp_status, resp_message, errors: resp_errors)
  end
  
  def self.edit_event(current_user, data)
    begin
      data   = data.with_indifferent_access
      event = Event.find_by_id(data[:event][:id])
      if event.user_id == current_user.id
        event.update_attributes(data[:event])
        resp_data    = event_response(event)
        resp_status  = 1
        resp_message = 'success'
        resp_errors  = ''
      else
        resp_data    = {}
        resp_status  = 1
        resp_message = 'You can\t edit this event or you are not the event creator.'
        resp_errors  = ''
      end
    rescue Exception => e
      resp_data       = {}
      resp_status     = 0
      resp_message    = 'error'
      resp_errors     = e
    end
    JsonBuilder.json_builder(resp_data, resp_status, resp_message, errors: resp_errors)
  end
  
  # def self.sync_event(current_user, data)
  #   begin
  #     data   =  data.with_indifferent_access
  #     per_page = (data[:per_page] || @@limit).to_i
  #     page     = (data[:page] || 1).to_i
  #     if data[:last_event_date].present?
  #       events = Event.where('created_at > ?', data[:last_event_date]).order('created_at DESC')
  #     else
  #       events = Event.all.order('created_at DESC')
  #     end
  #     if events.present?
  #       events       = events.page(page.to_i).per_page(per_page.to_i)
  #       paging_data  = JsonBuilder.get_paging_data(page, per_page, events)
  #       resp_data    = events_response(events)
  #       resp_status  = 1
  #       resp_message = 'Events list.'
  #       resp_errors  = ''
  #     else
  #       resp_data    = {}
  #       resp_status  = 0
  #       resp_message = 'No event found.'
  #       resp_errors  = ''
  #       paging_data  = ''
  #     end
  #   rescue Exception => e
  #     resp_data       = {}
  #     resp_status     = 0
  #     resp_message    = 'error'
  #     resp_errors     = e
  #     paging_data     = ''
  #   end
  #   JsonBuilder.json_builder(resp_data, resp_status, resp_message, errors: resp_errors, paging_data: paging_data)
  # end
  #
  def self.event_response(event)
    event = event.as_json(
       only:[:id, :event_name, :start_date, :end_date, :start_time, :end_time],
       include:{
           event_detail:{
               only:[:id, :institute_name, :institute_type, :location, :latitude, :longitude]
           },
           event_hall:{
               only:[:id, :hall_name],
               include:{
                   hall_details:{
                       only:[:id, :attachment_url, :thumbnail_url]
                   }
               }
           },
           bands:{
               only:[:id, :band_name],
               include:{
                   band_songs:{
                       only:[:id, :song_name]
                   },
                   band_members:{
                       only:[:id, :member_name, :member_type]
                   }
               }
           },
           back_stage_members:{
               only:[:id, :member_name]
           }
       }
    )
    
    {event: event}.as_json
  end
  
  def self.events_response(events)
    events = events.as_json(
        only:[:id, :event_name, :start_date, :end_date, :created_at, :updated_at, :start_time, :end_time],
        include:{
            event_detail:{
                only:[:id, :institute_name, :institute_type, :location, :latitude, :longitude]
            },
            event_hall:{
                only:[:id, :hall_name],
                include:{
                    hall_details:{
                        only:[:id, :attachment_url, :thumbnail_url]
                    }
                }
            },
            bands:{
                only:[:id, :band_name],
                include:{
                    band_songs:{
                        only:[:id, :song_name]
                    },
                    band_members:{
                        only:[:id, :member_name, :member_type]
                    }
                }
            },
            back_stage_members:{
                only:[:id, :member_name]
            }
        }
    )
    {events: events}.as_json
  end
end
