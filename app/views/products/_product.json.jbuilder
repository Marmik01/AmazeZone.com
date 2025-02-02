json.extract! product, :id, :name, :category, :quantity, :price, :created_at, :updated_at
json.url product_url(product, format: :json)
