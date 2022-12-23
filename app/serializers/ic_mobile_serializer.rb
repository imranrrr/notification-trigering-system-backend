class IcMobileSerializer
    include FastJsonapi::ObjectSerializer
    attributes :id, :name
    attribute :created_at do |object| 
        object.created_at && object.created_at.strftime("%d/%m/%Y");
    end
end