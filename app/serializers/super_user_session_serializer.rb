class SuperUserSessionSerializer
    include FastJsonapi::ObjectSerializer

    attributes :id, :email, :first_name, :last_name, :bypass_user, :role, :paid, :company_id, :status

    attribute :company do |user|
        if user.company.present? 
            { id: user.company.id, name: user.company.name, sub_domain: user.company.sub_domain, logo: user.company.logo }
        end
    end

    attribute :user_count do |object|
        if object.company.present? && object.company.users.present?
          {
            notification_users: object.company.users.where(role: 0).count, admins: object.company.users.where(role: 1).count
          }
        end
      end

    attribute :subscription do |user|
        if user.company.subscription.present?
          {id: user.company.subscription.id, package_name: user.company.subscription.package.name, start_date: user.company.subscription.start_date.strftime('%d/%m/%Y'), end_date: useruser.company.subscription.end_date.strftime('%d/%m/%Y'), subscription_duration: user.company.subscription.package.duration, package_price: user.company.subscription.package.price/100, locations_limit: user.company.subscription.package.locations_creating_limit, endpoints_limit: user.company.subscription.package.endpoints_creating_limit, endpoint_groups_limit: user.company.subscription.package.endpoint_groups_creating_limit, users_limit: user.company.subscription.package.users_creating_limit }
        end
    end
end