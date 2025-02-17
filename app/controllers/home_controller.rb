class HomeController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :create_login]

  def index
  end

  def create_login
    login = params[:email] 
    user = User.find_by(email: login) || User.find_by(matricula: login)

    if user && user.authenticate(params[:password])
      if user.role.nil?
        flash.now[:alert] = "O seu cadastro ainda não foi avaliado!"
        render :index
      else
        session[:user_email] = user.email
        redirect_to root_path, notice: "Login realizado com sucesso!"
      end
    else
      flash[:alert] = "Login ou senha inválidos."
      redirect_to login_path
    end
  end

  def logout
    session[:user_email] = nil
    redirect_to root_path, notice: "Logout realizado com sucesso!"
  end
end