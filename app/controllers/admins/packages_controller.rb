require 'stripe'

class Admins::PackagesController < ApplicationController
    before_action :authenticate_user!, only: %i[buy_package]
    before_action :set_package, only: %i[buy_package]

    def index
        @packages = Package.all
        render json: @packages
    end

    def create
      begin 
        package = Package.new(package_params)
        if package.save!
          render json: {
            package: package
          }
        end
        rescue => e
          render json: {
            status: 500, message: e.message
          }
        end
    end

    def buy_package
      begin
        Stripe.api_key = ENV["STRIPE_SECRET_KEY"]
        payment_intent = Stripe::PaymentIntent.create(
          amount: @package.price,
          currency: 'usd',
          automatic_payment_methods: {
            enabled: true,
          },
        )
        clientSecret = payment_intent['client_secret']
        
        if clientSecret
          Subscription.create!(user_id: current_user.id, status: 0, package_id: @package.id)
        end
        render json: {
          clientSecret: clientSecret
        }
      rescue => e
          render json: {
            status: 500, message: e.message
          }
      end
    end

    def redirect_request
        stripe_data = params[:stripeParams].split('&')
        payment_intent = stripe_data[0].split('payment_intent=')[1]
        stripe_result = payment_intent = stripe_data[2].split('redirect_status=')[1]

       if stripe_result == 'succeeded'
         package_duration = current_user.subscription.package.duration
         split_package_duration = package_duration.split(" ")
         duration_in_number = split_package_duration[0].to_i
         current_user.subscription.update(status: 1, start_date: Time.now, end_date: Time.now + duration_in_number.month)
         current_user.update(stripe_account_intent: payment_intent, paid: true)
       end
   
       render json: {status: 200, user: current_user.reload}
   
    end

    private 
     
    def set_package
        @package = Package.find_by(id: params[:id])
    end

    def package_params
      params.require(:package).permit(:name, :pirce, :duration)
    end
end