class Company < ApplicationRecord
    has_many :users, dependent: :destroy
    has_one :subscription, dependent: :destroy
    has_many :locations, dependent: :destroy
    has_many :endpoint_groups, dependent: :destroy
    has_many :endpoints, dependent: :destroy
    has_many :destinations, dependent: :destroy
    has_many :web_signages, dependent: :destroy
    has_many :templates

    validates :sub_domain, presence: true
    validates :sub_domain, exclusion: { in: %w(www us ca jp),
    message: "%{value} is reserved." }
    validates :sub_domain, uniqueness: true

    mount_uploader :logo, CompanyLogoUploader

    enum status: {
        inactive: 0,
        active: 1
    }

    enum paid: {
        unpaid: 0,
        paid: 1
    }
end
