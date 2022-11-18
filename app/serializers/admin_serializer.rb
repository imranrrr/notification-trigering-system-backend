class AdminSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :name, :email
end
