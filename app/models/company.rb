class Company < ApplicationRecord
    has_many :users

    mount_uploader :logo, CompanyLogoUploader

    enum status: {
        inactive: 0,
        active: 1
    }
end
