class CreateTransactions < ActiveRecord::Migration[6.0]
  def change
    create_table :transactions do |t|
      t.text :description
      t.integer :amount
      t.string :classification
      t.belongs_to :user
      t.timestamps
    end
  end
end
