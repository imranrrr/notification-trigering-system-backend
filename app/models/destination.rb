class Destination < ApplicationRecord
    has_one :endpoint, dependent: :destroy
    belongs_to :company, optional: true
    validates :destination_type, :resource_url, :network_distribution_id, presence: true
    belongs_to :user, foreign_key: :creator_id, optional: true

    enum destination_type: {
        "nil": 0,
        "IC Mobile": 1,
        "Signage": 2
    }
end
