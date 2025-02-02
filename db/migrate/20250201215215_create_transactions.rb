class CreateTransactions < ActiveRecord::Migration[8.0]
  def change
    create_table :transactions do |t|
      t.integer :transaction_number
      t.integer :quantity
      t.decimal :total_cost
      t.references :user, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true
      t.references :credit_card, null: false, foreign_key: true

      t.timestamps
    end
  end
end
