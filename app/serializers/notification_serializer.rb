class NotificationSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :template_id, :endpoint_id, :creator_id

  attribute :created_at do |notification|
    notification.created_at && notification.created_at.strftime("%d/%m/%Y")
  end

  attribute :template do |notification|
    if notification.template.present?
      {id: notification.template.id, name: notification.template.name}
    end
  end
  
  attribute :endpoint do |notification|
    if notification.endpoint.present?
      {id: notification.endpoint.id, name: notification.endpoint.name}
    end
  end

  attribute :user do |notification|
    if notification.user.present?
      {id: notification.user.id, name: notification.user.email}
    end
  end

end
