class TemplateSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :name, :subject, :body, :audio, :color, :user_id

  attribute :created_at do |template|
    template.created_at && template.created_at.strftime('%d/%m/%Y')
  end

  attribute :user do |template|
    {id: template.user.id, email: template.user.email}
  end
end
