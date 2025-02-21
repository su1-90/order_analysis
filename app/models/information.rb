class Information < ApplicationRecord
  self.table_name = 'informations'
  validates :message, presence: { message: 'メッセージは必須です。' }
end
