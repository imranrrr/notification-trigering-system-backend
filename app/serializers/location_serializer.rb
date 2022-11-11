class LocationSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :name, :web_signage_id, :description, :admin_id

  attribute :created_at do |location|
    location.created_at && location.created_at.strftime('%d/%m/%Y')
  end
end
