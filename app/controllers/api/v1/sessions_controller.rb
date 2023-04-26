class Api::V1::SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:email])
    
    
  end
end