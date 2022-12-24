# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json
 
  def create
   super
  end

  def update
    begin
      user = current_user
      user.update!(update_user_params)
      render json: {status: 200, message: "Profile Upated Successfully!", user: UserSerializer.new(user).serializable_hash[:data][:attributes]}
    rescue => e
      render json: {status: 500, message: e.message}
    end
  end

  private

  def respond_with(resource, _opts = {})
    if resource.persisted?
      render json: {
        status: {code: 200, message: 'Signed up successfully.'},
        data: UserSerializer.new(resource).serializable_hash[:data][:attributes]
      }
    else
      render json: {
        status: {message: "User couldn't be created successfully. #{resource.errors.full_messages.to_sentence}"}
      }, status: :unprocessable_entity
    end
  end

  def sign_up_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :company_id)
  end 
  
  def update_user_params
    params.require(:user).permit(:first_name, :last_name, :password, :password_confirmation, :company_id)
  end

end
