class EndpointGroupSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :name, :description, :endpoint_type, :creator_id
  
  attribute :created_at do |endpointGroup|
    endpointGroup.created_at && endpointGroup.created_at.strftime('%d/%m/%Y')
  end
end
