class CurrentUserController < ApplicationController
  # before_action :authenticate_user!
  
  def index
    render json: "this is #{current_user}", status: :ok
  end
end
