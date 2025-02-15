class HomeController < ApplicationController
  def index
    # Exibe o formulário de login (index.html.erb)
  end

  def create_login
    # Busca o usuário pelo email
    user = User.find_by(email: params[:email])

    # Verifica se o usuário existe e se a senha está correta
    if user && user.authenticate(params[:password])
      session[:user_email] = user.email
      redirect_to root_path, notice: "Login realizado com sucesso!"
    else
      flash.now[:alert] = "Email ou senha inválidos."
      render :index
    end
  end

  def logout
    session[:user_email] = nil
    redirect_to root_path, notice: "Logout realizado com sucesso!"
  end
end