class Subscription < ApplicationRecord
    belongs_to :package
	belongs_to :user
	has_many :transaction

	enum status: [:inactive, :active]
    
end
