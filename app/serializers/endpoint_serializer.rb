class EndpointSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :description, :location_id, :endpoint_group_id, :destination_id, :admin_id

  attribute :created_at do |endpoint|
    endpoint.created_at && endpoint.created_at.strftime('%d/%m/%Y')
  end 
end
