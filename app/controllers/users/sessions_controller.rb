# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  respond_to :json
  # before_action :configure_sign_in_params, only: [:create]


  private

  def respond_with(resource, _opts = {})
  byebug
    unless resource.read_attribute_before_type_cast(:role) == 0
      render json: {
        status: {code: 200, message: 'Logged in sucessfully.'},
        data: UserSignInSerializer.new(resource).serializable_hash[:data][:attributes]
      }, status: :ok
    else
      render json: {
        status: {code: 200, message: 'Logged in sucessfully.'},
        data: UserSerializer.new(resource).serializable_hash[:data][:attributes]
      }, status: :ok
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
