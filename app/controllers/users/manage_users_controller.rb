class Users::ManageUsersController < Users::UsersApiController
    before_action :set_user, only: %i[show update destroy]
    before_action :authenticate_user!

    def index
        begin
          if current_user.role == "Super User"
            company_users_for_super_user = User.where(company_id: current_company.id, role: "Administrator")
            users_except_super_user = User.where(company_id: current_company.id, role: "Notification User")
            @users = company_users_for_super_user + users_except_super_user
          elsif current_user.role == "Administrator"
            @users = User.where(company_id: current_company.id, role: "Notification User")
          end
          render json:{
            status: 200,
            users: UserSerializer.new(@users).serializable_hash[:data].map{|data| data[:attributes]}
          }
        rescue => e
          render json: {status: 500, message: e.message}
        end
    end

    def show
        begin
            render json: {
                status: 200,
                user: UpdateUserSerializer.new(@user).serializable_hash[:data][:attributes]
                }
        rescue => e
            render json: {status: 500, message: e.message}
        end
    end

    def create
      begin
        if check_subscription_limit?
          @user = User.new(user_params)
          @user.company_id = current_company.id
            if @user.save!
              render json: {
                status: 200,
                user: UserSerializer.new(@user).serializable_hash[:data][:attributes]
              }
            end
        else
          render json: {status: 500, message: "You have Reached Your Subscribed Users Limit!"}
        end
      rescue => e
        render json: {status: 500, message: e.message}
      end
    end

    def update
        begin
            if @user.update!(user_params)
              render json: {
                status: 200,
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
              status: 200,
                user: @user
            }
            @user.destroy!
        rescue => e
            render json: {status: 500, message: e.message}
        end
    end

    private

    def check_subscription_limit?
      if current_company.subscription.present?
        userCount = current_company.users.count 
        limitCount = current_company.subscription.package.users_creating_limit
        !(userCount >= limitCount)
      end
    end

    def set_user
        @user = User.find_by(id: params[:id])
    end

    def user_params
        params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :role, :provider, :uid, :status)
    end
end