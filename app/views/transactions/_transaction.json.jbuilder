json.extract! transaction, :id, :transaction_number, :quantity, :total_cost, :user_id, :product_id, :credit_card_id, :created_at, :updated_at
json.url transaction_url(transaction, format: :json)
