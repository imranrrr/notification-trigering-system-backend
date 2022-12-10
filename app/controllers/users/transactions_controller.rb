class Users::TransactionsController < Users::UsersApiController
    before_action :authenticate_user!
    before_action :set_transaction, only: %i[show]

    def index
        begin
            transactions = Transaction.where(user_id: current_user.id)
            # transactions = Transaction.all
            render json: {
                transactions: TransactionSerializer.new(transactions).serializable_hash[:data].map{|data| data[:attributes]}
            }
        rescue => e 
            render json: {
                status: 500, message: e.message
            }
        end
    end

    def show
        begin
            render json: {
               transaction: TransactionSerializer.new(@transaction).serializable_hash[:data][:attributes]
            }
        rescue => e
            render json: {
                status: 500, message: e.message
            }
        end

    end

    private 

    def set_transaction
        @transaction = Transaction.find_by(id: params[:id])
    end
end