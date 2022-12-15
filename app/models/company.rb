class Company < ApplicationRecord
    has_many :users, dependent: :destroy
    has_one :subscription, dependent: :destroy
    has_many :locations, dependent: :destroy
    has_many :endpoint_groups, dependent: :destroy
    has_many :endpoints, dependent: :destroy
    has_many :destinations, dependent: :destroy
    has_many :web_signages, dependent: :destroy

    mount_uploader :logo, CompanyLogoUploader

    enum status: {
        inactive: 0,
        active: 1
    }
end
