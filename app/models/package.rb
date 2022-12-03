class Package < ApplicationRecord
    has_many :subscription
    has_many :transactions
    before_save :update_price

    enum duration: {
        "1 Month": 0,
        "3 Months": 1,
        "6 Months": 2,
        "12 Months": 3
    }

    def update_price
        if self.price.present?
            self.price = self.price*100
        end
    end
    
end
