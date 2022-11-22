# frozen_string_literal: true

class Admins::RegistrationsController < Devise::RegistrationsController
  respond_to :json
  before_action :configure_account_update_params, only: [:update]

  def create
    super
  end

  def edit
    render json: {
      admin: current_admin
    }
  end

  def update
    begin
      current_admin.update!(configure_account_update_params)
      render json: {
        status: 200,
        message: "Account updated successfully!"
      }
      session.clear
    rescue => e
      render json: {status: 500, message: e.message}
    end
  end

  private

  def respond_with(resource, _opts = {})
    if resource.persisted?
      render json: {
        status: {code: 200, message: 'Signed up sucessfully.'},
        data: AdminSerializer.new(resource).serializable_hash[:data][:attributes]
      }
    else
      render json: {
        status: {message: "User couldn't be created successfully. #{resource.errors.full_messages.to_sentence}"}
      }, status: :unprocessable_entity
    end
  end

  def configure_account_update_params
    params.require(:admin).permit(:name, :email, :password, :password_confirmation)
  end

  def sign_up_params
    params.require(:admin).permit(:name, :email, :password, :password_confirmation)
  end
end
