class Transaction < ApplicationRecord
  CLASSIFICATIONS = [
    EXPENSE = "expense",
    INCOME = "income"
  ]

  belongs_to :user

  validates :description, :amount, :classification, presence: :true
  validates :classification, inclusion: { in: CLASSIFICATIONS }

end
