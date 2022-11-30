class Package < ApplicationRecord
    has_many :subscription
    has_many :transactions

    enum duration: {
        "1 Month": 0,
        "3 Months": 1,
        "6 Months": 2,
        "12 Months": 3
    }
end
