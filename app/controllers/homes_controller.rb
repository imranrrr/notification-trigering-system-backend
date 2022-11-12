class HomesController < ApplicationController
    before_action :user_is_logged_in?

    def index
        # render json: current_user, status: :ok
        puts(session[:oktastate])
        @current_user = User.find_by(uid: session[:oktastate])
        render json: @current_user, status: :ok
    end

end