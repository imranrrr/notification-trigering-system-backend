class EndpointGroupSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :name, :description, :admin_id

  attribute :endpoint_type do |endpointGroup|
    endpointGroup.endpoint_type && endpointGroup.read_attribute_before_type_cast(:endpoint_type)
  end 
  
  attribute :created_at do |endpointGroup|
    endpointGroup.created_at && endpointGroup.created_at.strftime('%d/%m/%Y')
  end
end
