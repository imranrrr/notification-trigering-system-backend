class EndpointGroupSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :description, :endpoint_type, :admin_id
  
  attribute :created_at do |endpointGroup|
    endpointGroup.created_at && endpointGroup.created_at.strftime('%d/%m/%Y')
  end
end
