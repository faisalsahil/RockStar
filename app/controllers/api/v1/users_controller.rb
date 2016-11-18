class Api::V1::UsersController < ApplicationController
  
  def login
    # params = {
    #     user: {
    #         email: 'faisal@gmail.com',
    #         password: 'zaqxsw1234'
    #     }
    # }
    
    resp_data = UserSession.login(params)
    return render json: resp_data
  end
  
end
