class WebSignage < ApplicationRecord
    has_one :location
    belongs_to :company, optional: true
    belongs_to :user, foreign_key: :creator_id, optional: true

    enum creator_type: {
        default: 0,
        user: 1
    }
end
