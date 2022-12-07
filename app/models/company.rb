class Company < ApplicationRecord
    has_many :users
    has_one :subscription
    has_many :locations
    has_many :endpoint_groups
    has_many :endpoints
    has_many :destinations
    has_many :web_signages

    mount_uploader :logo, CompanyLogoUploader

    enum status: {
        inactive: 0,
        active: 1
    }
end
