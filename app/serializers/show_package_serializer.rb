class ShowPackageSerializer
    include FastJsonapi::ObjectSerializer
    attributes :id, :name, :promotion, :locations_creating_limit, :endpoint_groups_creating_limit, :endpoints_creating_limit, :users_creating_limit

    attribute :duration do |object|
        object.duration && object.read_attribute_before_type_cast(:duration)
    end

    attribute :price do |object|
        object.price && object.price/100
    end

    attribute :created_at do |object| 
        object.created_at && object.created_at.strftime("%d/%m/%Y")
    end
end