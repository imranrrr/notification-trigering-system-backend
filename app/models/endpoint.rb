class Endpoint < ApplicationRecord
    belongs_to :location, optional: true
    belongs_to :endpoint_group, optional: true
    belongs_to :destination, optional: true
    has_many :notifications
    belongs_to :company, optional: true
    belongs_to :user, foreign_key: :creator_id, optional: true

    validates :name, :location_id, :endpoint_group_id, :destination_id, presence: true

end
