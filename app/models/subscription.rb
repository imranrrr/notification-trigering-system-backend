class Subscription < ApplicationRecord
    belongs_to :package
	belongs_to :company, optional: true
	has_many :transactions
	belongs_to :user, optional: true, foreign_key: :creator_id

	enum status: [:inactive, :active]
    
end
