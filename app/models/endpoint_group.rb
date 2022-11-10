class EndpointGroup < ApplicationRecord
    belongs_to :admin, optional: true

    enum endpoint_type: {
         audio: 1,
         text: 2,
         both: 3
        }
end
