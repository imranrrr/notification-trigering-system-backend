class AdminSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :email
end
