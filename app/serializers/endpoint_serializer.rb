class EndpointSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :name, :description, :location_id, :endpoint_group_id, :destination_id, :admin_id
  attribute :created_at do |endpoint|
    endpoint.created_at && endpoint.created_at.strftime('%d/%m/%Y')
  end

  attribute :location do |endpoint|
    if endpoint.location.present?
      {name: endpoint.location.name}
    end
  end 

  attribute :destination do |endpoint|
    if endpoint.destination.present?
      {destination_type: endpoint.destination.destination_type, resource_url: endpoint.destination.resource_url,network_distribution_id: endpoint.destination.network_distribution_id}
    end
  end
end
