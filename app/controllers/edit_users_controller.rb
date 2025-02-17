class EditUsersController < ApplicationController
    before_action :authenticate_user!
    before_action :set_user, only: [:edit, :update, :destroy]
    before_action :authorize_user!, only: [:edit, :update, :destroy]
  
    def edit
    end

    def update
      if @user.update(user_params)
        redirect_to links_path, notice: 'Usuário atualizado com sucesso.'
      else
        flash.now[:alert] = @user.errors.full_messages.join(", ")
        render :edit
      end
    end
    
    def destroy
      if @user.destroy
        redirect_to root_path, notice: 'Conta excluída com sucesso.'
      else
        redirect_to edit_edit_user_path(current_user), alert: 'Erro ao excluir a conta. Tente novamente.'
      end
    end
    
    private
    
    def set_user
      @user = User.find(params[:id])
    end

    def authorize_user!
      unless current_user == @user
        redirect_to links_path, alert: 'Você não tem permissão para editar este perfil.'
      end
    end

    def user_params
      params.require(:user).permit(:usuario, :password, :password_confirmation)
    end
end