class PackageSerializer
    include FastJsonapi::ObjectSerializer
    attributes :id, :name, :promotion, :locations_creating_limit, :endpoint_group_creatin_limit, :endpoints_creating_limit, :users_creating_limit

    attribute :duration do |object|
        object.duration && object.read_attribute_before_type_cast(:duration)
    end

    attribute :created_at do |object| 
        object.created_at && object.created_at.strftime("%d/%m/%Y")
    end
end