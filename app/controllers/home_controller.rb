# Controlador responsável pela página inicial, login, logout e redirecionamento de usuários.
# Gerencia o processo de autenticação e exibe a página de links após login bem-sucedido.
class HomeController < ApplicationController

  # Ignora a autenticação para as ações `index` e `create_login`.
  skip_before_action :authenticate_user!, only: [:index, :create_login]

  # Garante que o usuário será redirecionado se já estiver logado.
  before_action :redirect_if_logged_in, only: [:index]

  # Exibe a página inicial, permitindo o login se o usuário não estiver autenticado.
  #
  # @return [void] Exibe a página inicial (formulário de login).
  def index
  end

  # Realiza a autenticação do usuário a partir do parâmetro de login (email ou matrícula).
  # Caso o login seja bem-sucedido, o usuário é redirecionado para a página de links.
  # Se o usuário não estiver aprovado, exibe uma mensagem de alerta.
  # Caso contrário, exibe uma mensagem de erro de autenticação.
  #
  # @return [void] Redireciona para a página de links ou exibe erro caso o login falhe.
  def create_login
    user = find_user_by_login_param(login_param)
    
    if authenticated_user?(user)
      handle_authentication_result(user)
    else
      handle_failed_authentication
    end
  end

  # Realiza o logout do usuário, removendo o e-mail da sessão e redirecionando para a página inicial.
  #
  # @return [void] Redireciona para a página inicial com mensagem de sucesso no logout.
  def logout
    session[:user_email] = nil
    redirect_to root_path, notice: "Logout realizado com sucesso!"
  end

  # Exibe os links do usuário autenticado. 
  # Esta ação está acessível apenas se o usuário estiver autenticado.
  #
  # @return [void] Exibe a página de links.
  def links
  end

  private

  # Retorna o parâmetro de email que foi enviado no formulário de login.
  #
  # @return [String] O valor do parâmetro `email` enviado na requisição.
  def login_param
    params[:email]
  end

  # Retorna o parâmetro de senha enviado no formulário de login.
  #
  # @return [String] O valor do parâmetro `password` enviado na requisição.
  def password_param
    params[:password]
  end

  # Busca um usuário pelo email ou matrícula, dependendo do parâmetro de login.
  #
  # @param login [String] O valor do login enviado (pode ser email ou matrícula).
  # @return [User, nil] O usuário encontrado ou `nil` caso não exista.
  def find_user_by_login_param(login)
    User.find_by(email: login) || User.find_by(matricula: login)
  end

  # Verifica se o usuário fornecido foi autenticado com a senha fornecida.
  #
  # @param user [User] O usuário que será autenticado.
  # @return [Boolean] `true` se a senha for válida, `false` caso contrário.
  def authenticated_user?(user)
    user&.authenticate(password_param)
  end

  # Lida com o resultado da autenticação do usuário. Se o usuário ainda não foi aprovado,
  # exibe um alerta informando que o cadastro está pendente. Caso contrário, realiza o login.
  #
  # @param user [User] O usuário que foi autenticado.
  # @return [void] Redireciona para a página de links ou exibe um alerta.
  def handle_authentication_result(user)
    if user.role.nil?
      handle_pending_approval
    else
      handle_successful_login(user)
    end
  end

  # Lida com o login bem-sucedido do usuário. Armazena o e-mail na sessão e redireciona
  # para a página de links com uma mensagem de sucesso.
  #
  # @param user [User] O usuário autenticado.
  # @return [void] Redireciona para a página de links com sucesso no login.
  def handle_successful_login(user)
    session[:user_email] = user.email
    redirect_to links_path, notice: "Login realizado com sucesso!"
  end
  # Lida com a situação onde o cadastro do usuário está pendente de aprovação. Exibe
  # um alerta informando que o cadastro ainda precisa ser aprovado.
  #
  # @return [void] Exibe uma mensagem de alerta na página inicial.
  def handle_pending_approval
    flash.now[:alert] = "O seu cadastro ainda não foi avaliado!"
    render :index
  end

  # Lida com falha na autenticação, redirecionando o usuário para a página de login
  # com uma mensagem de erro.
  #
  # @return [void] Redireciona para a página de login com erro de autenticação.
  def handle_failed_authentication
    flash[:alert] = "Login ou senha inválidos."
    redirect_to login_path
  end

  # Retorna o usuário atualmente autenticado com base no e-mail armazenado na sessão.
  #
  # @return [User, nil] O usuário autenticado ou `nil` caso não haja sessão ativa.
  def current_user
    @current_user ||= User.find_by(email: session[:user_email]) if session[:user_email].present?
  end

  # Redireciona o usuário para a página de links se ele já estiver autenticado.
  #
  # @return [void] Redireciona para a página de links se o usuário já estiver logado.
  def redirect_if_logged_in
    if current_user.present?
      redirect_to links_path, notice: "Você já está logado!"
    end
  end
  
end
