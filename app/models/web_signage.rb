class WebSignage < ApplicationRecord
    has_one :location
    belongs_to :company, optional: true
    belongs_to :user, optional: true, foreign_key: :creator_id

    enum creator_type: {
        default: 0,
        user: 1
    }
end
