class Api::V1::SessionsController < ApplicationController
  def create
    # binding.pry
    user = User.find_by(email: params[:email])
    # binding.pry
    if user && user.authenticate(params[:password])
      # binding.pry
      session[:user_id] = user.id
      # binding.pry
      render json: UserSerializer.new(user), status: 200
    else
      render json: { errors: 'Your credentials are bad and you should feel bad' }, status: 400
    end
  end
end