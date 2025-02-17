class User < ApplicationRecord
  has_secure_password

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }, on: :create
  validates :role, inclusion: { in: ["discente", "docente", "administrador", nil] }
  
  validates :course, presence: true
  validates :matricula, presence: true, uniqueness: true
  validates :usuario, presence: true
  validates :formacao, inclusion: { in: ["Graduando", "Graduado", "Pós-graduação", "Mestrado", "Doutorado"], allow_blank: true }
  
  def update_role(new_role)
    self.role = new_role
    save(validate: false)
  end
end
