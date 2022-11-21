class Admins::UsersController < ApplicationController
    before_action :set_user, only: %i[show update destroy]

    def index
        begin
            @users = User.all
            render json:{
              users: UserSerializer.new(@users).serializable_hash[:data].map{|data| data[:attributes]}
            }
          rescue => e
            render json: {status: 500, message: e.message}
          end
    end

    def show
        begin
            render json: {
                user: UpdateUserSerializer.new(@user).serializable_hash[:data][:attributes]
                }
        rescue => e
            render json: {status: 500, message: e.message}
        end
    end

    def create
        @user = User.new(user_params)
        begin
          if @user.save!
            render json: {
              user: UserSerializer.new(@user).serializable_hash[:data][:attributes]
            }
          end
        rescue => e
          render json: {status: 500, message: e.message}
        end
    end

    def update
        begin
            if @user.update!(user_params)
              render json: {
                user: UserSerializer.new(@user).serializable_hash[:data][:attributes]
              }
            end
          rescue => e
            render json: {status: 500, message: e.message}
          end
    end

    def destroy
        begin
            render json: {
                message: "you just destroyed! User!",
                user: @user
            }
            @user.destroy!
        rescue => e
            render json: {status: 500, message: e.message}
        end
    end

    private

    def set_user
        @user = User.find_by(id: params[:id])
    end

    def user_params
        params.require(:user).permit(:first_name, :last_name, :email, :password, :bypass_user, :role, :provider, :uid)
    end
end