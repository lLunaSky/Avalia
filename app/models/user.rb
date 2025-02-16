class User < ApplicationRecord
  has_secure_password

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }, on: :create
  validates :role, inclusion: { in: ["discente", "docente", "administrador", nil] }

  def update_role(new_role)
    self.role = new_role
    save(validate: false)
  end
end