class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
    def oktaoauth
        byebug
        @user = User.from_omniauth(request.env["omniauth.auth"])
        session[:oktastate] = request.env["omniauth.auth"]["uid"]
    end
end