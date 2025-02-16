class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable

  validates :user_code, presence: true, uniqueness: true

  def admin?
    self.admin # または self.is_admin など、admin 属性の名前
  end
end
