class IcMobile < ApplicationRecord
    has_one :destination, foreign_key: :network_distribution_id
end
