class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_email] = nil
      redirect_to login_path, notice: "Cadastro realizado com sucesso! Faça login."
    else
      flash.now[:alert] = @user.errors.full_messages.join(", ")
      render :new
    end
  end

  private

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
      :formacao,
    )
  end
end