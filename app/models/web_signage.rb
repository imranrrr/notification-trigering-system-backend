class WebSignage < ApplicationRecord
    has_one :location
    belongs_to :company
    belongs_to :user, foreign_key: :creator_id

    enum creator_type: {
        default: 0,
        user: 1
    }
end
