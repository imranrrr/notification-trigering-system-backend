class LocationSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :web_signage, :admin_id

  attribute :created_at do |location|
    location.created_at && location.created_at.strftime('%d/%m/%Y')
  end
end
