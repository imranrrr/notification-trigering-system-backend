class Admins::NotificationsController < ApplicationController
    before_action :set_notification, only: %i[ show destroy ]
    before_action :authenticate_admin!
  
    def index
        begin
            notifications = Notification.all
            render json:  {
                status: 200,
                notifications: NotificationSerializer.new(notifications).serializable_hash[:data].map{|data| data[:attributes]}
            }
        rescue => e
            render json: {status: 500, message: e.message}
        end
    end
  
    def show
        begin
            render json:  {
                status: 200,
                notification: NotificationSerializer.new(@notification).serializable_hash[:data][:attributes]
            }
        rescue => e
            render json: {status: 500, message: e.message}
        end
    end
  
    def create
        endpoint_ids = notification_params[:endpoint_ids]
        begin
            if endpoint_ids.length > 0
                endpoint_ids.each do |endpoint_id|
                    notification = Notification.create!(template_id: notification_params[:template_id], endpoint_id: endpoint_id, user_id: notification_params[:user_id], admin_id: notification_params[:admin_id]) 
                end
                render json: {
                    status: 200,
                    message: "Notifications has been created! :)"
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
                notification: @notification
            }
            @notification.destroy
        rescue => e
            render json: {status: 500, message: e.message} 
        end
    end
  
    private
      def set_notification
        @notification = Notification.find(params[:id])
      end
  
      def notification_params
        params.require(:notification).permit(:template_id, :admin_id, :user_id, :endpoint_ids => [] )
      end
  end