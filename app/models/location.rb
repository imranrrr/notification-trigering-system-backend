class Location < ApplicationRecord
    has_many :endpoints
    belongs_to :web_signage, foreign_key: :web_signage_id, optional: true
    validates :name, presence: true
end
