class UserSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :email, :first_name, :last_name, :bypass_user, :role, :paid, :company_id, :status

  attribute :company do |user|
    if user.company.present? 
      {
        id: user.company.id, name: user.company.name, sub_domain: user.company.sub_domain
      }
    end
  end

  attribute :user_count do |object|
    if object.company.present? && object.company.users.present?
      {
        notification_users: object.company.users.where(role: 0).count, admins: object.company.users.where(role: 1).count
      }
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
