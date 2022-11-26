class Transaction < ApplicationRecord
    belongs_to :user, optional: true
    belongs_to :subscription, optional: true
    belongs_to :package, optional: true
end
