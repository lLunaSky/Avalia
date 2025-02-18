class HomeController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :create_login]
  before_action :redirect_if_logged_in, only: [:index]

  def index
  end

  def create_login
    user = find_user_by_login_param(login_param)
    
    if authenticated_user?(user)
      handle_authentication_result(user)
    else
      handle_failed_authentication
    end
  end

  def logout
    session[:user_email] = nil
    redirect_to root_path, notice: "Logout realizado com sucesso!"
  end

  def links
  end

  private

  def login_param
    params[:email]
  end

  def password_param
    params[:password]
  end

  def find_user_by_login_param(login)
    User.find_by(email: login) || User.find_by(matricula: login)
  end

  def authenticated_user?(user)
    user&.authenticate(password_param)
  end

  def handle_authentication_result(user)
    if user.role.nil?
      handle_pending_approval
    else
      handle_successful_login(user)
    end
  end

  def handle_successful_login(user)
    session[:user_email] = user.email
    redirect_to links_path, notice: "Login realizado com sucesso!"
  end

  def handle_pending_approval
    flash.now[:alert] = "O seu cadastro ainda não foi avaliado!"
    render :index
  end

  def handle_failed_authentication
    flash[:alert] = "Login ou senha inválidos."
    redirect_to login_path
  end

  def current_user
    @current_user ||= User.find_by(email: session[:user_email]) if session[:user_email].present?
  end

  def redirect_if_logged_in
    if current_user.present?
      redirect_to links_path, notice: "Você já está logado!"
    end
  end
end
