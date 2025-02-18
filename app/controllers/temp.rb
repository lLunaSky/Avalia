class UsersController < ApplicationController
    skip_before_action :authenticate_user!, only: [:new, :create]
  
    def new
      @user = User.new
    end
  
    def create
      @user = User.new(user_params)
  
      if @user.save
        handle_successful_signup
      else
        handle_failed_signup
      end
    end
  
    private
  
    def handle_successful_signup
      clear_session_email
      redirect_to login_path, notice: "Cadastro realizado com sucesso! Faça login."
    end
  
    def handle_failed_signup
      set_flash_errors
      render :new
    end
  
    def clear_session_email
      session[:user_email] = nil
    end
  
    def set_flash_errors
      flash.now[:alert] = @user.errors.full_messages.join(", ")
    end
  
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
  