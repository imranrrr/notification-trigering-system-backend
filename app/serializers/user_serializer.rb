class UserSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :email

  attribute :templates do |user|
    user.templates && user.templates.map{|template|  {id: template.id, name: template.name, subject: template.subject, body: template.body, audio: template.audio, background_color: template.background_color, font_color: template.font_color }}
  end

  attribute :created_date do |user|
    user && user.created_at.strftime('%d/%m/%Y')
  end
end
