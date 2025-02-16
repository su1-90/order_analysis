class Information < ApplicationRecord
  validates :title, presence: true, allow_blank: true
  validates :message, allow_blank: true
end