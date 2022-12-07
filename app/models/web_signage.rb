class WebSignage < ApplicationRecord
    has_one :location
    belongs_to :company
end
