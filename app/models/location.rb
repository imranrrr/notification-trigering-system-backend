class Location < ApplicationRecord
    has_many :endpoints
    belongs_to :web_signage

    validates :name, :web_signage_id, presence: true
end
