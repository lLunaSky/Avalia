class User < ApplicationRecord
  has_secure_password

  validates :name, presence: true
  validates :email, presence: true, uniqueness: {case_sensitive: false}
  
  validates :password, length: {minimum: 6, message: "deve ter pelo menos 6 caracteres"}, allow_blank: true
  validates :password, confirmation: {message: "e senha devem ser iguais"}, allow_blank: true
  validates :password_confirmation, presence:  {message: "é obrigatório quando a senha for preenchida"}, if: -> { password.present?}

  validates :role, inclusion: {in: ["discente", "docente", "administrador", nil]}
  validates :course, presence: true, on: :create 
  validates :matricula, presence: true, uniqueness: true, format: { with: /\A\d+\z/}, on: :create 
  validates :usuario, presence: true
  validates :formacao, inclusion: {in: ["Graduando", "Graduado", "Pós-graduação", "Mestrado", "Doutorado"], allow_blank: true}

  def password_changed?
    password.present?
  end

  def update_role(new_role)
    update(role: new_role)
  end
end