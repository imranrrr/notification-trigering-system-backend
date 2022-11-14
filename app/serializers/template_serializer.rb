class TemplateSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :name, :subject, :body, :audio, :background_color, :font_color, :user_id, :admin_id
  attribute :created_at do |template|
    template.created_at && template.created_at.strftime('%d/%m/%Y')
  end

  attribute :user do |template|
    if template.user.present?
      {id: template.user.id, email: template.user.email}
    end
  end

  attribute :admin do |template|
    if template.admin.present?
      {id: template.admin.id, email: template.admin.email}
    end
  end
end
