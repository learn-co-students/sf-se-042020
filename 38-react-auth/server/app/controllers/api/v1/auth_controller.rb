class Api::V1::AuthController < ApplicationController
  def create
    user = User.find_by(username: params[:username])
    
    if user && user.authenticate(params[:password])
      my_token = issue_token(user)
      
      render json: {id: user.id, username: user.username, token: my_token}
    else
      render json: {error: 'That user could not be found'}, status: 401
    end
  end


  
  def show
    if logged_in?
      render json: { id: current_user.id, username: current_user.username }
    else
      render json: {error: 'No user could be found'}, status: 401
    end
  end
end
