class ApplicationController < ActionController::Base
  # protect_from_forgery with: :exception
  helper_method :admin?, :access_write_project, :access_read_project, :marketer?
  include AppConstants

  def admin?
    if current_user && current_user.role.name == ADMIN
      true
    else
      false
    end
  end
  
  def invalid_token_response
    resp_data       = {}
    resp_status     = 0
    paging_data     = ''
    resp_message    = 'error'
    resp_errors     = 'Invalid token.'
    JsonBuilder.json_builder(resp_data, resp_status, resp_message,  errors: resp_errors)
  end
end
