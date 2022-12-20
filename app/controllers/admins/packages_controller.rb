require 'stripe'
require 'sinatra'

class Admins::PackagesController < ApplicationController
  before_action :authenticate_user!, only: %i[buy_package]
  before_action :set_package, only: %i[buy_package]
   
    def index
        @packages = Package.all
        render json: 
        {
          status: 200,
          packages: @packages
        }
    end

    def create
      begin 
        package = Package.new(package_params)
        if package.save!
          render json: {
            status: 200,
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
      byebug
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
        subscription = current_user.company.subscription if current_user.company.subscription.present?
        if clientSecret && subscription
              subscription.update!(package_id: @package.id, status: 1)
        elsif clientSecret
              Subscription.create!(company_id: current_user.company.id, status: 1, package_id: @package.id)
        end
        render json: {
          status: 200,
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
        stripe_result = stripe_data[2].split('redirect_status=')[1]
        # payment_intent = 'pi_3MG1sUFgUyec9R6615vmZp6L'
        # stripe_result = 'succeeded'

       if stripe_result == 'succeeded'
         subscription = current_user.company.subscription
         subscription.update!(status: 2)
         current_user.company.update(stripe_account_intent: payment_intent, paid: 1)
       end
   
       render json: {status: 200, user: current_user.reload}
   
    end

    private 

    def set_package
        @package = Package.find_by(id: params[:id])
    end

    def package_params
      params.require(:package).permit(:name, :price, :duration)
    end
end