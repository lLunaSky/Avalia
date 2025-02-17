class PasswordResetsController < ApplicationController
    before_action :authenticate_user!
    before_action :authorize_admin_or_docente, only: [:index, :reset_password]
  
    def index
        if params[:email].present?
          @user = User.find_by(email: params[:email]) || User.find_by(matricula: params[:email])
        end
        render 'pesquisa'
      end      
  
    def reset_password
        @user = User.find(params[:id])
    
        if @user
            new_password = rand(100000..999999).to_s
    
            if @user.update(password: new_password, password_confirmation: new_password)
            redirect_to password_resets_path(email: @user.email), 
                        notice: "Senha resetada com sucesso! Nova senha: #{new_password}"
            else
            redirect_to password_resets_path(email: @user.email), 
                        alert: "Erro ao resetar senha: #{@user.errors.full_messages.join(', ')}"
            end
        else
            redirect_to password_resets_path, alert: "Usuário não encontrado."
        end
    end
  
    private
  
    def authorize_admin_or_docente
        unless current_user.role.in?(['administrador', 'docente'])
            redirect_to root_path, alert: "Acesso negado."
        end
    end
end