class NotificationSerializer
  include FastJsonapi::ObjectSerializer
  attributes :template_id, :endpoint_id, :user_id, :admin_id

  attribute :created_at do |notification|
    notification.created_at && notification.created_at.strftime("%d/%m/%Y")
  end
  
end
