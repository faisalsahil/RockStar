class Api::V1::EventsController < ApplicationController
  include JsonBuilder
  
  def create_event
    params = {
        event: {
            event_name: 'Cricket 2016',
            start_date: '2016-11-18 12:34:33',
            end_date:   '2016-11-21 12:34:33',
            event_detail_attributes:{
                institute_name: 'PUCIT',
                institute_type: 'Education',
                location:        'Anarkali Lahore, Pakistan',
                latitude:        '222222.2222',
                longitude:       '444.43422'
            },
            event_hall_attributes: {
                hall_name: 'Alhumrah hall# 12',
                hall_details_attributes:[
                  {
                      attachment_url: 'https://www.youtube.com/watch?v=zZzF7pBVDSk',
                      thumbnail_url:  'https://media.giphy.com/media/o6S51npJYQM48/giphy.gif',
                  }
                ]
            },
            bands_attributes:[
              {
                band_name: 'Coak Studio',
                band_songs_attributes:[
                  {
                      song_name: 'Cocacola pila dy.'
                  },
                  {
                      song_name: 'tujhy mn pyar kru...'
                  }
                ],
                band_members_attributes:[
                  {
                      member_name: 'jenna',
                      member_type: 'asdasd'
                  },
                  {
                      member_name: 'tujhy mn pyar kru...',
                      member_type: 'cddcdcdc'
                  }
                ]
              },
              {
                band_name: 'Rock Star',
                band_songs_attributes:[
                  {
                      song_name: 'Cocacola pila dy.'
                  },
                  {
                      song_name: 'tujhy mn pyar kru...'
                  }
                ],
                band_members_attributes:[
                  {
                      member_name: 'jenna',
                      member_type: 'asdasd'
                  },
                  {
                      member_name: 'tujhy mn pyar kru...',
                      member_type: 'cddcdcdc'
                  }
                ]
              }
            ],
            back_stage_members_attributes: [
              {
                  member_name: 'John'
              },
              {
                  member_name: 'Dustin'
              }
            ]
        },
        auth_token: 'a041f30f64be1a04358b1ba88dc9f26b5c68c184987b873585a2078867c25e2c8e43a124921bcbdcdf6b1c0cc1e4860fc8c97b857050e2411041349267e53c9ea395bb5346117c72ced3eb2774cc9ebc0f210de9e64e06eca3144919e9e0b6ada4acc47a'
    }

    user_session = UserSession.find_by_auth_token(params[:auth_token])
    if user_session.present?
      resp_data = Event.create_event(user_session.user, params)
      return render json: resp_data
    else
      resp_data       = invalid_token_response
      return render json: resp_data
    end
  end
  
  def event_list
    # params = {
    #     page: 1,
    #     per_page: 2,
    #     auth_token: '244082ac4748145d25eeabac08c7b936493ac77ec27a90a7cf064c011e833fb42c3ea6c0be3b624251163269124f1162ff560406f6bd127ab0410f5acd058f6d5b9e3d74d8160eb721ace30f8ac714beef0b70366c372e95f9264557c65c1d39912f6210'
    # }
    user_session = UserSession.find_by_auth_token(params[:auth_token])
    if user_session.present?
      resp_data = Event.event_list(user_session.user, params)
      return render json: resp_data
    else
      resp_data       = invalid_token_response
      return render json: resp_data
    end
  end
  
  def show_event
    # params = {
    #     auth_token: '244082ac4748145d25eeabac08c7b936493ac77ec27a90a7cf064c011e833fb42c3ea6c0be3b624251163269124f1162ff560406f6bd127ab0410f5acd058f6d5b9e3d74d8160eb721ace30f8ac714beef0b70366c372e95f9264557c65c1d39912f6210',
    #     event: {
    #         id: 5
    #     }
    # }
    user_session = UserSession.find_by_auth_token(params[:auth_token])
    if user_session.present?
      resp_data = Event.show_event(user_session.user, params)
      return render json: resp_data
    else
      resp_data       = invalid_token_response
      return render json: resp_data
    end
  end
  
  def off_sync
    # params = {
    #     event: [
    #       {
    #         event_name: 'Cricket 2016',
    #         start_date: '2016-11-18 12:34:33',
    #         end_date:   '2016-11-21 12:34:33',
    #         event_detail_attributes:{
    #             institute_name: 'PUCIT',
    #             institute_type: 'Education',
    #             location:       'Anarkali Lahore, Pakistan',
    #             latitude:       '22.2222',
    #             longitude:      '3333.33'
    #         },
    #         event_hall_attributes: {
    #             hall_name: 'Alhumrah hall# 12',
    #             hall_details_attributes:[
    #               {
    #                   attachment_url: 'https://www.youtube.com/watch?v=zZzF7pBVDSk',
    #                   thumbnail_url:  'https://media.giphy.com/media/o6S51npJYQM48/giphy.gif',
    #               }
    #             ]
    #         },
    #         bands_attributes:[
    #           {
    #             band_name: 'Coak Studio',
    #             band_songs_attributes:[
    #               {
    #                   song_name: 'Cocacola pila dy.'
    #               },
    #               {
    #                   song_name: 'tujhy mn pyar kru...'
    #               }
    #             ],
    #             band_members_attributes:[
    #               {
    #                   member_name: 'jenna',
    #                   member_type: 'asdasd'
    #               },
    #               {
    #                   member_name: 'tujhy mn pyar kru...',
    #                   member_type: 'cddcdcdc'
    #               }
    #             ]
    #           },
    #           {
    #             band_name: 'Rock Star',
    #             band_songs_attributes:[
    #               {
    #                   song_name: 'Cocacola pila dy.'
    #               },
    #               {
    #                   song_name: 'tujhy mn pyar kru...'
    #               }
    #             ],
    #             band_members_attributes:[
    #               {
    #                   member_name: 'jenna',
    #                   member_type: 'asdasd'
    #               },
    #               {
    #                   member_name: 'tujhy mn pyar kru...',
    #                   member_type: 'cddcdcdc'
    #               }
    #             ]
    #           }
    #         ],
    #         back_stage_members_attributes: [
    #           {
    #               member_name: 'John'
    #           },
    #           {
    #               member_name: 'Dustin'
    #           }
    #         ]
    #       }
    #     ],
    #     auth_token: '244082ac4748145d25eeabac08c7b936493ac77ec27a90a7cf064c011e833fb42c3ea6c0be3b624251163269124f1162ff560406f6bd127ab0410f5acd058f6d5b9e3d74d8160eb721ace30f8ac714beef0b70366c372e95f9264557c65c1d39912f6210'
    # }
    user_session = UserSession.find_by_auth_token(params[:auth_token])
    if user_session.present?
      resp_data = Event.off_sync(user_session.user, params)
      return render json: resp_data
    else
      resp_data       = invalid_token_response
      return render json: resp_data
    end
  end
  
  def sync_events
    # params = {
    #     auth_token: '244082ac4748145d25eeabac08c7b936493ac77ec27a90a7cf064c011e833fb42c3ea6c0be3b624251163269124f1162ff560406f6bd127ab0410f5acd058f6d5b9e3d74d8160eb721ace30f8ac714beef0b70366c372e95f9264557c65c1d39912f6210',
    #     last_event_date: '2016-11-18 19:05:10',
    #     page:            1,
    #     per_page:        10
    # }
    user_session = UserSession.find_by_auth_token(params[:auth_token])
    if user_session.present?
      resp_data = Event.sync_event(user_session.user, params)
      return render json: resp_data
    else
      resp_data       = invalid_token_response
      return render json: resp_data
    end
  end
end
