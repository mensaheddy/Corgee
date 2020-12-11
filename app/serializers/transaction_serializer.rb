class TransactionSerializer < ActiveModel::Serializer
  attributes :id, :description, :amount, :classification
end
