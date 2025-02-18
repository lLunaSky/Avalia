# Controlador responsável pela redefinição de senhas dos usuários. 
# Este controlador permite que um administrador ou docente possa resetar a senha de um usuário.
class PasswordResetsController < ApplicationController

    # Exige que o usuário esteja autenticado antes de acessar qualquer ação.
    before_action :authenticate_user!

    # Permite que apenas administradores ou docentes possam acessar as ações `index` e `reset_password`.
    before_action :authorize_admin_or_docente, only: [:index, :reset_password]

    # Define o usuário antes de executar a ação `reset_password`.
    before_action :find_user, only: [:reset_password]

    # Verifica se o usuário está presente antes de executar a ação `reset_password`.
    before_action :validate_user_presence, only: [:reset_password]
  
    # Exibe a página de pesquisa para reset de senha. Se o parâmetro de email estiver presente,
    # realiza a busca do usuário.
    #
    # @return [void] Exibe a página de pesquisa.
    def index
        search_user if params[:email].present?
        render 'pesquisa'
    end
  
    # Reseta a senha do usuário encontrado. A senha será gerada de forma aleatória e o usuário
    # será notificado sobre a nova senha.
    #
    # @return [void] Redireciona para a página de pesquisa com uma mensagem de sucesso ou erro.
    def reset_password
        new_password = generate_random_password
        
        if @user.update(password: new_password, password_confirmation: new_password)
            redirect_with_password(new_password)
        else
            redirect_with_errors
        end
    end
  
    private
  
    # Realiza a busca do usuário utilizando o email ou matrícula.
    #
    # @return [void] Define a variável `@user` com o usuário encontrado ou `nil` caso não exista.
    def search_user
        @user = User.find_by(email: params[:email]) || User.find_by(matricula: params[:email])
    end
  
    # Encontra o usuário pelo id passado nos parâmetros da requisição.
    #
    # @return [void] Define a variável `@user` com o usuário encontrado.
    def find_user
        @user = User.find_by(id: params[:id])
    end
  
    # Verifica se o usuário existe. Caso contrário, redireciona para a página de pesquisa com um alerta.
    #
    # @return [void] Redireciona com alerta caso o usuário não seja encontrado.
    def validate_user_presence
        return if @user.present?
        redirect_to password_resets_path, alert: "Usuário não encontrado."
    end
  
    # Gera uma senha aleatória no formato de número de 6 dígitos.
    #
    # @return [String] A nova senha gerada.
    def generate_random_password
        rand(100_000..999_999).to_s
    end
  
    # Redireciona para a página de pesquisa com uma mensagem de sucesso incluindo a nova senha.
    #
    # @param password [String] A nova senha gerada.
    # @return [void] Redireciona com sucesso e a nova senha.
    def redirect_with_password(password)
        redirect_to password_resets_path(email: @user.email),
            notice: "Senha resetada com sucesso! Nova senha: #{password}"
    end
  
    # Redireciona para a página de pesquisa com uma mensagem de erro caso a redefinição da senha falhe.
    #
    # @return [void] Redireciona com erro e as mensagens de erro do usuário.
    def redirect_with_errors
        redirect_to password_resets_path(email: @user.email),
            alert: "Erro ao resetar senha: #{@user.errors.full_messages.join(', ')}"
    end
  
    # Verifica se o usuário tem o papel de administrador ou docente. Caso contrário, o acesso é negado.
    #
    # @return [void] Redireciona para a página inicial com mensagem de "Acesso negado" caso o usuário
    #                não seja autorizado.
    def authorize_admin_or_docente
        return if current_user.role.in?(%w[administrador docente])
        redirect_to root_path, alert: "Acesso negado."
    end

 end