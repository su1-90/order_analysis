# User seeds
users_data = [
  { user_code: 'admin02', password: 'password', password_confirmation: 'password', admin: true },
  { user_code: 'admin03', password: 'password', password_confirmation: 'password', admin: true },
  { user_code: 'user02', password: 'password', password_confirmation: 'password', admin: false },
  { user_code: 'user03', password: 'password', password_confirmation: 'password', admin: false },
  { user_code: 'user04', password: 'password', password_confirmation: 'password', admin: false }
]

users_data.each do |user_data|
  User.create!(user_data)
end

# Item seeds
items_data = [
  { product_code: '111111', name: 'サンプル弁当', order_date: '2025-02-10', order_quantity: 790 },
  { product_code: '111111', name: 'サンプル弁当', order_date: '2025-02-09', order_quantity: 560 },
  { product_code: '111111', name: 'サンプル弁当', order_date: '2025-02-08', order_quantity: 1440 },
  { product_code: '111111', name: 'サンプル弁当', order_date: '2025-02-07', order_quantity: 1020 },
  { product_code: '111111', name: 'サンプル弁当', order_date: '2025-02-06', order_quantity: 1680 }
]

items_data.each do |item_data|
  Item.create!(item_data)
end
