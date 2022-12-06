class CompanyUpdateSerializer
    include FastJsonapi::ObjectSerializer
    attributes :id, :name, :sub_domain, :okta_sso_login

    attribute :status do |company|
        company.status && company.read_attribute_before_type_cast(:status)
    end

    attribute :created_at do |company|
        company.created_at && company.created_at.strftime("%d/%m/%Y")
    end

    attribute :logo do |company|
        if company.logo.present?
          {url: company.logo.url, filename: company.logo.file.filename}
        end
      end

    attribute :users do |company|
        if company.users.present?
            company.users.map do |user|
                {id: user.id, email: user.email, first_name: user.first_name, last_name: user.last_name}
            end
        end
    end

end