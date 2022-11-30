class UserSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :email, :first_name, :last_name, :bypass_user, :role, :paid

  attribute :templates do |user|
    user.templates && user.templates.map{|template|  {id: template.id, name: template.name, subject: template.subject, body: template.body, audio: template.audio, background_color: template.background_color, font_color: template.font_color }}
  end

  attribute :created_date do |user|
    user && user.created_at.strftime('%d/%m/%Y')
  end

  attribute :subscription do |user|
    if user.subscription.present?
      {id: user.subscription.id, package_name: user.subscription.package.name, start_date: user.subscription.start_date.strftime('%d/%m/%Y'), end_date: user.subscription.end_date.strftime('%d/%m/%Y'), subscription_duration: user.subscription.package.duration, package_price: user.subscription.package.price/100 }
    end
  end
end
