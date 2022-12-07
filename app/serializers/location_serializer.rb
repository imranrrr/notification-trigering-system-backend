class LocationSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :name, :web_signage_id, :description, :creator_id

  attribute :web_signage do |location|
    if location.web_signage.present?
      {id: location.web_signage.id, name: location.web_signage.name}
    end
  end
  attribute :created_at do |location|
    location.created_at && location.created_at.strftime('%d/%m/%Y')
  end
end
