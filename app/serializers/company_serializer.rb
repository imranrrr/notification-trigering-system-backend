class CompanySerializer
    include FastJsonapi::ObjectSerializer
    attributes :id, :name, :sub_domain

    attribute :created_at do |company|
        company.created_at && company.created_at.strftime("%d/%m/%Y")
    end

    attribute :user do |company|
        if company.user.present?
            {id: company.user.id, email: company.user.email, first_name: company.user.first_name, last_name: company.user.last_name}
        end
    end
end