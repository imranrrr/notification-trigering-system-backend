class ApplicationController < ActionController::API

    before_action :configure_permitted_parameters, if: :devise_controller?


    def user_is_logged_in?
      if !session[:oktastate]
        print("this is not Logged in")
        # redirect_to user_oktaoauth_omniauth_authorize_path
      end
    end

    def after_sign_in_path_for(resource)
      request.env["onniauth.origin"]
    end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :role, :bypass_user, :email, :password, :company_id])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:email, :password])
  end

end
