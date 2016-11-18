class UserSession < ApplicationRecord
  include JsonBuilder
  # include HashToObject
  
  belongs_to :user
  
  def self.login(data)
    data = data.with_indifferent_access
    if data[:user][:email].present?
      user = User.find_by_email(data[:user][:email])
    end
    if user && user.valid_password?(data[:user][:password])
      user_session = user.user_session
      user_session.destroy if user_session.present?
      
      user_session                = user.build_user_session
      user_session.auth_token     = SecureRandom.hex(100)
      user_session.save!
      #
      # user.current_sign_in_at     = Time.now
      # user.synced_datetime        = nil
      # user.last_subscription_time = nil
      # user.save!
      resp_data = login_response(user, user_session.auth_token)
      resp_status     = 1
      resp_message    = 'User Profile'
      resp_errors     = ''
    else
      resp_data       = {}
      resp_status     = 0
      resp_message    = 'Errors'
      resp_errors     = 'Either your email or password is incorrect'
    end
    JsonBuilder.json_builder(resp_data, resp_status, resp_message, errors: resp_errors)
  end

  def self.login_response(user, auth_token)
    user = user.as_json(
        only:    [:id, :email]
    ).merge!(auth_token: auth_token).as_json
  
    {user: user}.as_json
  end
end
