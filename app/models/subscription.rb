class Subscription < ApplicationRecord
    belongs_to :package
	belongs_to :company, optional: true
	has_many :transactions
	belongs_to :user, optional: true, foreign_key: :creator_id
	before_save :set_subscription_duration

	enum status: [:inactive, :requested, :active]

	def set_subscription_duration
		package_duration = self.package.duration
		split_package_duration = package_duration.split(" ")
		duration_in_number = split_package_duration[0].to_i
		self.start_date = Time.now
		self.end_date = Time.now + duration_in_number.month
	end
    
end
