class Users::NotificationsController < ApplicationController
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
    endpoint_ids = notification_params[:endpoint_ids]
    @notifications = []
    endpoint_ids.each do |endpoint_id|
        @notifications << Notification.create!(template_id: notification_params[:template_id], endpoint_id: endpoint_id, user_id: notification_params[:user_id], admin_id: notification_params[:admin_id])
    end
    render json: {
        notifications: NotificationSerializer.new(@notifications).serializable_hash[:data].map{|data| data[:attributes]}
    }

  end

 
#   def update
#     if @notification.update(notification_params)
#       render json: @notification
#     else
#       render json: @notification.errors, status: :unprocessable_entity
#     end
#   end

 
#   def destroy
#     @notification.destroy
#   end

#   def manage_notifications
#     byebug
#     template_id = notification_params[:template_id]
#     endpoint_ids = notification_params[:endpoint_ids]
#     @template = Template.find_by(id: template_id)
#     @endpoints = []
#     endpoint_ids.each do |id|
#         @endpoints << Endpoint.find_by(id: id) 
#     end
#     render json: {
#         template: TemplateSerializer.new(@template).serializable_hash[:data][:attributes],
#         endpoints: EndpointSerializer.new(@endpoints).serializable_hash[:data].map{|data| data[:attributes]}
#     }
# end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_notification
      @notification = Notification.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def notification_params
      params.require(:notification).permit(:template_id, :admin_id, :user_id, :endpoint_ids => [] )
    end

end