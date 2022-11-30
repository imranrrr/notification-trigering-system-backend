class TransactionSerializer
    include FastJsonapi::ObjectSerializer
    attributes :id

    attribute :created_at do |transaction|
        transaction.created_at && transaction.created_at.strftime("%d/%m/%Y")
    end

    attribute :user do |transaction|
        if transaction.user.present?
            {
                id: transaction.user.id, email: transaction.user.email
            }
        end
    end

    attribute :package do |transaction|
        if transaction.package.present?
            {id: transaction.package.id, name: transaction.package.name, duration: transaction.package.duration, price: transaction.package.price}
        end
    end

    attribute :subscription do |transaction|
        if transaction.subscription.present?
            {id: transaction.subscription.id, start_date: transaction.subscription.start_date, end_date: transaction.subscription.end_date}
        end
    end

end