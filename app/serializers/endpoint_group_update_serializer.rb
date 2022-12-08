class EndpointGroupUpdateSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :name, :description, :creator_id

  attribute :creator_type do |endpoint_group|
    endpoint_group.creator_type && endpoint_group.read_attribute_before_type_cast(:creator_type)
  end

  attribute :endpoint_type do |endpointGroup|
    endpointGroup.endpoint_type && endpointGroup.read_attribute_before_type_cast(:endpoint_type)
  end  
end
