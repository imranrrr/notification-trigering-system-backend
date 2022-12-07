class EndpointGroupUpdateSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :name, :description, :creator_id

  attribute :endpoint_type do |endpointGroup|
    endpointGroup.endpoint_type && endpointGroup.read_attribute_before_type_cast(:endpoint_type)
  end  
end
