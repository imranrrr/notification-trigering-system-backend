class Subscription < ApplicationRecord
    belongs_to :package
	belongs_to :company
	has_many :transactions

	enum status: [:inactive, :active]
    
end
