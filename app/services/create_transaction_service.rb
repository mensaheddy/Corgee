class CreateTransactionService

  attr_reader :attributes

  def initialize(attributes:)
    @attributes = attributes
  end

  def call
    transaction = Transaction.new(attributes)

    if transaction.save
      Outcome.Success(transaction)
    else
      Outcome.Failure(errors: transaction.errors.full_messages)
    end
  end
end