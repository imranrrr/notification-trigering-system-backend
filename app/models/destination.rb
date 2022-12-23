class Destination < ApplicationRecord
    has_one :endpoint
    belongs_to :company, optional: true
    validates :destination_type, :resource_url, :network_distribution_id, presence: true
    belongs_to :user, optional: true, foreign_key: :creator_id
    belongs_to :ic_mobile, optional: true, foreign_key: :network_distribution_id

    enum destination_type: {
        "nil": 0,
        "IC Mobile": 1,
        "Signage": 2
    }

    enum creator_type: {
        default: 0,
        user: 1
    }
end
