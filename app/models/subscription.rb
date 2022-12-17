class Subscription < ApplicationRecord
    belongs_to :package
	belongs_to :company, optional: true
	has_many :transactions
	belongs_to :user, optional: true, foreign_key: :creator_id
	# after_create :set_subscription_duration

	enum status: [:inactive, :requested, :active]

	def self.set_subscription_duration(subscription)
		package_duration = subscription.package.duration
		split_package_duration = package_duration.split(" ")
		duration_in_number = split_package_duration[0].to_i
		subscription.update!(status: 2, start_date: Time.now, end_date: Time.now + duration_in_number.month)
	end
    
end
