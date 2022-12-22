class AdminSideUserUpdateSerializer
    include FastJsonapi::ObjectSerializer
    attributes :id, :email, :first_name, :last_name, :bypass_user, :company_id, :role
  
    attribute :status do |user|
      user.read_attribute_before_type_cast(:status)
    end
  
    attribute :created_date do |user|
      user && user.created_at.strftime('%d/%m/%Y')
    end
  
    attribute :company_name do |user|
      user.company && user.company.name
    end
  end
  