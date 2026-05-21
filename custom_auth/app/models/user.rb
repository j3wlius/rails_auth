class User < ApplicationRecord
  has_secure_password

  validates :email, presence: true,
    uniqueness: { case_sensitive: false },
    format: { with: URI::MailTo::EMAIL_REGEXP }

  validates :password, presence: true,
    length: {minium: 8},
    if: -> { new_record? || changes[:password] }

  before_save :downcase_email

  private

  def downcase_email
    self.email = email.downcase
  end
end
