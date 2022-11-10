class Endpoint < ApplicationRecord
    belongs_to :location
    belongs_to :endpoint_group
    belongs_to :destination

    validates :name, :location_id, :endpoint_group_id, :destination_id, presence: true

end
