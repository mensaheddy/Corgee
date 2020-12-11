class TransactionsController < ApplicationController
  before_action :find_transaction, only: [:update, :destroy, :show]
  before_action :validate_ownership_of_transaction!, only: [:update, :destroy, :show]

  def index
    @transactions = Transaction.where(user: current_user).limit(50) #  should be paginated or scaled someway

    render json: @transactions, each_serializer: TransactionSerializer, status: :ok
  end

  def create
    outcome = CreateTransactionService.new(attributes: transaction_attributes).call

    if outcome.success?
      render :json => { success: true }, status: :ok
    else
      render :json => outcome.error, status: :unprocessable_entity
    end
  end

  def show
    render json: @transaction, serializer: TransactionSerializer, status: :ok
  end

  def update
    outcome = UpdateTransactionService.new(attributes: transaction_attributes, transaction: @transaction).call

    if outcome.success?
      render :json => { success: true }, status: :ok
    else
      render :json => { errors: outcome.error }, status: :unprocessable_entity
    end
  end

  def destroy
    if @transaction.destroy
      render :json => { success: true }, status: :ok
    else
      render :json => { errors: outcome.error }, status: :unprocessable_entity
    end
  end

  private

  def transaction_attributes
    params.require(:transaction).permit(:description, :amount, :classification, :user_id)
  end

  def find_transaction
    @transaction ||= Transaction.find_by(id: params[:id])
  end

  def validate_ownership_of_transaction!
    unless @transaction.user == current_user
      raise ExceptionsHandler::UnauthorizedAccess, "Unauthorized access to this transaction"
      # logging mechanism should be implemented
    end
  end
end