class EndpointGroup < ApplicationRecord
    belongs_to :user, foreign_key: :creator_id, optional: true
    has_many :endpoints
    belongs_to :company, optional: true

    validates :name, presence: true

    enum endpoint_type: {
         both: 1,
         audio: 2,
         text: 3,
        }
end
