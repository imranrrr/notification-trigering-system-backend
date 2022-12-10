class UserSignInSerializer
    include FastJsonapi::ObjectSerializer

    attributes :id, :email, :first_name, :last_name, :bypass_user, :role, :paid, :company_id, :status

    attribute :company do |user|
        if user.company.present? 
            { id: user.company.id, name: user.company.name, sub_domain: user.company.sub_domain }
        end
    end

    attribute :subscription do |user|
        if user.company.subscription.present?
          {id: user.company.subscription.id, package_name: user.company.subscription.package.name, start_date: user.company.subscription.start_date.strftime('%d/%m/%Y'), end_date: useruser.company.subscription.end_date.strftime('%d/%m/%Y'), subscription_duration: user.company.subscription.package.duration, package_price: user.company.subscription.package.price/100 }
        end
    end
end