class SubscriptionsController < Users::UsersApiController

    before_action :set_subscription, only: %i[show update destroy]
    before_action :authenticate_user!

    def index
        begin
            subscriptions = Subscription.find_by(company_id: current_company.id)
            render json: {
                status: 200,
                subscriptions: subscriptions
            }
        rescue => e
            render json: {status: 500, message: e.message }
        end
    end

    def show
        begin
        render json: {
            status: 200,
            subscription: @subscription
        }
        rescue => e
            render json: {status: 500, message: e.message}
        end
    end

    def update
        begin
            if @subscription.update!(subscription_params)
               render json: {
                    status: 200,
                    subscription: @subscription
                 }
            end
        rescue => e
          render json: {status: 500, message: e.message}
        end
    end

    def destroy
        begin
            @subscription.destroy    
        rescue => e
            render json: { status: 500, message: e.message }
        end
    end

    private

    def set_subscription
        @subscription = Subscription.find_by(id: params[:id])
    end

    def subscription_params
        params.require(:subscription.permit(:status, :package_id, :company_id))
    end
end