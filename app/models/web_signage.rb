class WebSignage < ApplicationRecord
    has_one :location
    belongs_to :company
    belongs_to :user, foreign_key: :creator_id
end
