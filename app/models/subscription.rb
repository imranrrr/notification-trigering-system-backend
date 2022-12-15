class Subscription < ApplicationRecord
    belongs_to :package
	belongs_to :company, optional: true
	has_many :transactions
	belongs_to :user, optional: true, foreign_key: :creator_id

	enum status: [:inactive, :active]

	def self.set_subscription_duration
		package_duration = self.package.duration
		split_package_duration = package_duration.split(" ")
		duration_in_number = split_package_duration[0].to_i
		self.update!(status: 1, start_date: Time.now, end_date: Time.now + duration_in_number.month)
	end
    
end
