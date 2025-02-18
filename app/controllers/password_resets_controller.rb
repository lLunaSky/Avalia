class PasswordResetsController < ApplicationController
    before_action :authenticate_user!
    before_action :authorize_admin_or_docente, only: [:index, :reset_password]
    before_action :find_user, only: [:reset_password]
    before_action :validate_user_presence, only: [:reset_password]
  
    def index
        search_user if params[:email].present?
        render 'pesquisa'
    end
  
    def reset_password
        new_password = generate_random_password
        
        if @user.update(password: new_password, password_confirmation: new_password)
            redirect_with_password(new_password)
        else
            redirect_with_errors
        end
    end
  
    private
  
    def search_user
        @user = User.find_by(email: params[:email]) || User.find_by(matricula: params[:email])
    end
  
    def find_user
        @user = User.find_by(id: params[:id])
    end
  
    def validate_user_presence
        return if @user.present?
        redirect_to password_resets_path, alert: "Usuário não encontrado."
    end
  
    def generate_random_password
        rand(100_000..999_999).to_s
    end
  
    def redirect_with_password(password)
        redirect_to password_resets_path(email: @user.email),
            notice: "Senha resetada com sucesso! Nova senha: #{password}"
    end
  
    def redirect_with_errors
        redirect_to password_resets_path(email: @user.email),
            alert: "Erro ao resetar senha: #{@user.errors.full_messages.join(', ')}"
    end
  
    def authorize_admin_or_docente
        return if current_user.role.in?(%w[administrador docente])
        redirect_to root_path, alert: "Acesso negado."
    end
  end