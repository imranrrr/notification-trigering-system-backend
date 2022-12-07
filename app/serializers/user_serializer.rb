class UserSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :email, :first_name, :last_name, :bypass_user, :role, :paid, :company_id, :status

  attribute :company_name do |user|
    user.company && user.company.name
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

  # attribute :subscription do |user|
  #   if user.subscription.present?
  #     {id: user.subscription.id, package_name: user.subscription.package.name, start_date: user.subscription.start_date.strftime('%d/%m/%Y'), end_date: user.subscription.end_date.strftime('%d/%m/%Y'), subscription_duration: user.subscription.package.duration, package_price: user.subscription.package.price/100 }
  #   end
  # end

  attribute :templates do |user|
      templates = Template.where(creator_id: user.id)
    if templates.present?
      templates.map{|template|  {id: template.id, name: template.name, subject: template.subject, body: template.body, audio: template.audio, background_color: template.background_color, font_color: template.font_color }}
    end
  end
end
