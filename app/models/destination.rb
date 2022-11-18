class Destination < ApplicationRecord
    has_one :endpoint, dependent: :destroy
    # validates :destination_type, :resource_url, :network_distribution_id, presence: true

    enum destination_type: {
        "nil": 0,
        "IC Mobile": 1,
        "Signage": 2
    }
end
