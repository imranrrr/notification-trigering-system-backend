class IntegrationSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :client_id, :client_secret, :base_url

  attribute :created_at do |integration|
    integration.created_at && integration.created_at.strftime('%d/%m/%Y')
  end
end
