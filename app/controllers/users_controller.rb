# app/controllers/users_controller.rb
class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:new, :create] # Permite acesso sem autenticação

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to login_path, notice: "Cadastro realizado com sucesso! Faça login."
    else
      flash.now[:alert] = "Erro ao cadastrar. Verifique os campos."
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :role)
  end
end