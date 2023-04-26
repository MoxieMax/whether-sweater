class Api::V1::SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:email])
    
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      
      render json: UserSerializer.new(user), status: 200
    else
      render json: { errors: 'Your credentials are bad and you should feel bad' }, status: 400
    end
  end
end