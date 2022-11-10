class Destination < ApplicationRecord

    enum destination_type: {
        "nil": 0,
        "IC Mobile": 1,
        "Signage": 2
    }
end
