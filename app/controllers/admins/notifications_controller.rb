class Admins::NotificationsController < ApplicationController
    before_action :set_notification, only: %i[ show destroy ]
  
    def index
        begin
            notifications = Notification.all
            render json:  {
                notifications: NotificationSerializer.new(notifications).serializable_hash[:data].map{|data| data[:attributes]}
            }
        rescue => e
            render json: {status: 500, message: e.message}
        end
    end
  
    def show
        begin
            render json:  {
                notification: NotificationSerializer.new(@notification).serializable_hash[:data][:attributes]
            }
        rescue => e
            render json: {status: 500, message: e.message}
        end
    end
  
    def manage_notifications
        begin
            Notification.manage_notifications(notification_params)
            render json: {
                status: 200,
                message: "Notifications has been created! :)"
            }
        rescue => e
            render json: {status: 500, message: e.message}
        end
    end
  
  
    def destroy
        begin
            render json: {
                status: 200,
                message: "You just Destroyed! Notification!",
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