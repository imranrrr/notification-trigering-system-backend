class Admins::NotificationsController < ApplicationController
    before_action :set_notification, only: %i[ show ]
  
    def index
        begin
            @notifications = Notification.all
  
            render json:  {
                notifications: NotificationSerializer.new(@notifications).serializable_hash[:data].map{|data| data[:attributes]}
            }
        rescue => e
            render json: e.message
        end
    end
  
    def show
        begin
            render json:  {
                notification: NotificationSerializer.new(@notification).serializable_hash[:data][:attributes]
            }
        rescue => e
            render json: e.message
        end
    end
  
    def manage_notifications
        begin
            endpoint_ids = notification_params[:endpoint_ids]
            @notifications = []
            endpoint_ids.each do |endpoint_id|
                @notifications << Notification.create!(template_id: notification_params[:template_id], endpoint_id: endpoint_id, user_id: notification_params[:user_id], admin_id: notification_params[:admin_id])
            end
            render json: {
                notifications: NotificationSerializer.new(@notifications).serializable_hash[:data].map{|data| data[:attributes]}
            }
        rescue => e
            render json: e.message
        end
    end
  
  
    def destroy
      render json: {
          status: 200,
          message: "You just Destroyed! Notification!",
          notification: @notification
      }
      @notification.destroy
    end
  
    private
      def set_notification
        @notification = Notification.find(params[:id])
      end
  
      def notification_params
        params.require(:notification).permit(:template_id, :admin_id, :user_id, :endpoint_ids => [] )
      end
  end