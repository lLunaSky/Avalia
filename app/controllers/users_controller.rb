# Controlador responsável pela criação de novos usuários.
# Ele permite que um novo usuário se cadastre no sistema, fornecendo informações como nome, email e senha.
class UsersController < ApplicationController
  
  # Pula a autenticação do usuário para as ações `new` e `create`, permitindo o acesso público.
  skip_before_action :authenticate_user!, only: [:new, :create]

  # Exibe o formulário de cadastro de um novo usuário.
  #
  # @return [void] Renderiza a página para o cadastro de usuário.
  def new
    @user = User.new
  end

  # Cria um novo usuário a partir dos parâmetros fornecidos.
  # Caso o cadastro seja bem-sucedido, redireciona para a página de login.
  # Caso contrário, renderiza o formulário de cadastro novamente com os erros.
  #
  # @return [void] Redireciona para a página de login ou renderiza o formulário de cadastro.
  def create
    @user = User.new(user_params)
    
    if @user.save
      handle_successful_signup
    else
      handle_failed_signup
    end
  end

  private

  # Manipula o caso de cadastro bem-sucedido. Limpa o email da sessão e redireciona o usuário para a página de login.
  #
  # @return [void] Redireciona para a página de login com mensagem de sucesso.
  def handle_successful_signup
    clear_session_email
    redirect_to login_path, notice: "Cadastro realizado com sucesso! Faça login."
  end

  # Manipula o caso de falha no cadastro. Define uma mensagem de erro e renderiza o formulário de cadastro novamente.
  #
  # @return [void] Renderiza o formulário de cadastro com as mensagens de erro.
  def handle_failed_signup
    set_flash_errors
    render :new
  end

  # Limpa o email da sessão após o sucesso no cadastro.
  #
  # @return [void] Limpa a chave `:user_email` na sessão.
  def clear_session_email
    session[:user_email] = nil
  end

  # Define as mensagens de erro do cadastro na variável `flash.now[:alert]` para exibição.
  #
  # @return [void] Define a mensagem de erro no flash para ser exibida na próxima requisição.
  def set_flash_errors
    flash.now[:alert] = @user.errors.full_messages.join(", ")
  end

  # Permite os parâmetros permitidos para criar um novo usuário. Inclui nome, email, senha, entre outros.
  #
  # @return [ActionController::Parameters] Os parâmetros permitidos para criar o usuário.
  def user_params
    params.require(:user).permit(
      :name,
      :email,
      :password,
      :password_confirmation,
      :role,
      :course,
      :matricula,
      :usuario,
      :formacao
    )
  end

end