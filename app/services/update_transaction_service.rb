class UpdateTransactionService
  attr_reader :attributes, :transaction

  def initialize(attributes:, transaction:)
    @attributes = attributes
    @transaction = transaction
  end

  def call
    if transaction.update(attributes)
      Outcome.Success(transaction)
    else
      Outcome.Failure(errors: transaction.errors.full_messages)
    end
  end
end