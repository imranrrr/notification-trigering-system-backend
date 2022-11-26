class Subscription < ApplicationRecord
    belongs_to :package
	belongs_to :user
	has_one :transaction

	enum status: [:inactive, :active]
    
end
