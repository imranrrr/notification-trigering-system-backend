class UserSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :email, :first_name, :last_name, :bypass_user, :role, :paid, :company_id, :status

  attribute :company do |user|
    if user.company.present? 
      { id: user.company.id, name: user.company.name, logo: user.company.logo} 
    end
  end

  attribute :created_date do |user|
    user && user.created_at.strftime('%d/%m/%Y')
  end

  # attribute :templates do |user|
  #     templates = Template.where(creator_id: user.id)
  #   if templates.present?
  #     templates.map{|template|  {id: template.id, name: template.name, subject: template.subject, body: template.body, audio: template.audio, background_color: template.background_color, font_color: template.font_color }}
  #   end
  # end

end
