# Controlador responsável pela edição, atualização e exclusão de usuários.
# Apenas o próprio usuário autenticado pode editar ou excluir sua conta.
class EditUsersController < ApplicationController

    # Garante que o usuário esteja autenticado antes de qualquer ação.
    before_action :authenticate_user!
    
    # Define o usuário que será editado, atualizado ou excluído com base no ID fornecido na URL.
    before_action :set_user, only: [:edit, :update, :destroy]
    
    # Garante que o usuário autenticado tenha permissão para editar, atualizar ou excluir sua própria conta.
    before_action :authorize_user!, only: [:edit, :update, :destroy]
    
    # Exibe o formulário de edição do usuário.
    #
    # @return [void] Exibe o formulário de edição para o usuário autenticado.
    def edit
    end
    
    # Exclui a conta do usuário.
    #
    # @return [void] Redireciona para a página inicial com uma mensagem de sucesso ou falha
    # caso a exclusão da conta não seja bem-sucedida.
    def destroy
        if @user.destroy
            redirect_to root_path, notice: 'Conta excluída com sucesso.'
        else
            redirect_to edit_edit_user_path(current_user), alert: 'Erro ao excluir a conta. Tente novamente.'
        end
    end
    
    # Atualiza as informações do usuário.
    #
    # @return [void] Redireciona para a página de links com uma mensagem de sucesso caso a atualização
    # seja bem-sucedida. Caso contrário, redireciona de volta para o formulário de edição com mensagens de erro.
    def update
        if @user.update(user_params)
            handle_successful_update
        else
            handle_failed_update
        end
    end
      
    private
    
    # Método chamado quando a atualização do usuário é bem-sucedida.
    #
    # @return [void] Redireciona para a página de links com a mensagem de sucesso.
    def handle_successful_update
        redirect_to links_path, notice: 'Usuário atualizado com sucesso.'
    end
    
    # Método chamado quando a atualização do usuário falha.
    #
    # @return [void] Redireciona de volta para o formulário de edição com as mensagens de erro.
    def handle_failed_update
        set_error_flash
        redirect_to edit_edit_user_path(@user), alert: flash[:alert]
    end
    
    # Configura a mensagem de erro e os parâmetros do formulário em caso de falha na atualização.
    #
    # @return [void] Configura a mensagem de erro no `flash[:alert]` e os parâmetros no `flash[:form_params]`.
    def set_error_flash
        flash[:alert] = @user.errors.full_messages.join(", ")
        flash[:form_params] = user_params.to_h
    end
    
    # Define o usuário a ser editado, atualizado ou excluído com base no ID fornecido.
    #
    # @return [void] Define a variável de instância `@user` para o usuário correspondente ao ID.
    def set_user
        @user = User.find(params[:id])
    end
    
    # Verifica se o usuário autenticado está tentando editar ou excluir sua própria conta.
    #
    # @return [void] Redireciona para a página de links com uma mensagem de erro se o usuário não tiver permissão.
    def authorize_user!
        unless current_user == @user
            redirect_to links_path, alert: 'Você não tem permissão para editar este perfil.'
        end
    end
    
    # Permite apenas os parâmetros necessários para atualizar o usuário: `:usuario`, `:password` e `:password_confirmation`.
    #
    # @return [ActionController::Parameters] Permite os parâmetros `:usuario`, `:password`, `:password_confirmation`.
    def user_params
        params.require(:user).permit(:usuario, :password, :password_confirmation)
    end
    
end