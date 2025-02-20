class Information < ApplicationRecord
  self.table_name = 'informations'
  validates :message, presence: true
end
