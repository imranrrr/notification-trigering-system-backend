class DestinationSerializer
  include FastJsonapi::ObjectSerializer
  attributes :destination_type, :resource_url, :network_distribution_id, :admin_id

  attribute :created_at do |destination|
    destination.created_at && destination.created_at.strftime('%d/%m/%Y')
  end
end
