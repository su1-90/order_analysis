class Information < ApplicationRecord
  self.table_name = 'informations'
  validates :message, presence: true, allow_blank: true
end
