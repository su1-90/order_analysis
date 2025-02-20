class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable

  validates :user_code, presence: { message: 'ユーザーコードは必須です。' }, uniqueness: { message: 'ユーザーコードは既に存在します。' }

  before_destroy :ensure_not_last_admin, prepend: true

  def email_required?
    false
  end

  def email_changed?
    false
  end

  def will_save_change_to_email?
    false
  end

  def admin?
    self.admin
  end

  private

  def ensure_not_last_admin
    if admin? && User.where(admin: true).count == 1
      errors.add(:base, '少なくとも1人の管理者ユーザーが必要です。')
      throw(:abort)
    end
  end
end
