class EndpointGroup < ApplicationRecord
    belongs_to :admin, optional: true
    has_many :endpoints
    validates :name, presence: true

    enum endpoint_type: {
         both: 1,
         audio: 2,
         text: 3,
        }
end
