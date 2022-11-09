class EndpointGroup < ApplicationRecord
    belongs_to :admin, optional: true

    enum endpoint_type: {
         both: 1,
         audio: 2,
         text: 3
        }
end
