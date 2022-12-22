# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  respond_to :json
  # before_action :configure_sign_in_params, only: [:create]


  private

  def respond_with(resource, _opts = {})
    if resource.status == "active"
      render json: {
        status: {code: 200, message: 'Logged in sucessfully.'},
        data: UserSessionSerializer.new(resource).serializable_hash[:data][:attributes]
      }, status: :ok
    else
      render json: {status: 500, message: "Looks like your account isn't active. Please contact to your Administrator!"}
    end
  end

  def respond_to_on_destroy
    begin
    if !current_user
      render json: {
        status: 200,
        message: "logged out successfully"
      }, status: :ok
    end
  rescue
      render json: {
        status: 401,
        message: "Couldn't find an active session."
      }, status: :unauthorized
    end
  end
end
