class Company < ApplicationRecord
    has_many :users

    enum status: {
        inactive: 0,
        active: 1
    }
end
