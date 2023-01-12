require 'json'
require 'devise_token_auth'
class Users::SocialAuthController < ApplicationController
    
    def authenticate_social_auth_user
        #  params is the response I receive from the client with the data from the provider about the user
        @user = User.signin_or_create_from_provider(params) # this method add a user who is new or logins an old one
        if @user.persisted?
          # I log the user in at this point
          sign_in(@user)
          # after user is loggedIn, I generate a new_token here
          login_token = @user.create_new_auth_token
          render json: {
            status: {code: 200, message: 'Logged in sucessfully.'},
            data: UserSessionSerializer.new(@user).serializable_hash[:data][:attributes],
            token: login_token
          },
            status: :created
        else
          render json: {
            status: 'FAILURE',
            message: "There was a problem signing you in through #{params[:provider]}",
            data: @user.errors
          },
            status: :unprocessable_entity
        end
      end
end