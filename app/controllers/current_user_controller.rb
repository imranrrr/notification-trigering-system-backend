class CurrentUserController < ApplicationController
  # before_action :authenticate_admin!
  
  def index
    render json: current_admin, status: :ok
  end

  def my_engine
    render json: "this is testing"
  end
end
