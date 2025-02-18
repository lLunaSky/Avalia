# Controlador responsável pela aprovação e rejeição de usuários.
# Ele permite que um administrador ou docente aprove ou recuse o cadastro de outros usuários.
class ApprovalsController < ApplicationController

  # Garante que o usuário esteja autenticado antes de qualquer ação.
  before_action :authenticate_user!

  # Restringe o acesso a determinadas ações para usuários com o papel de administrador ou docente.
  before_action :authorize_admin_or_docente, only: [:index, :approve_user, :reject_user]
  
  # Define o usuário a ser aprovado ou rejeitado com base no ID fornecido na URL.    
  before_action :set_user, only: [:approve_user, :reject_user]
  
  # Exibe a lista de usuários pendentes de aprovação.
  #
  # @return [void] Exibe a view `pending_approvals` com os usuários pendentes.
  def index
    @pending_users = User.where(role: nil)
    render 'pending_approvals'
  end

  # Rejeita o usuário (deleta o cadastro).
  #
  # @return [void] Redireciona para a página de aprovação com um aviso de sucesso ou falha.
  def reject_user
    @user.destroy!
    redirect_to pending_approvals_path, notice: "Cadastro recusado com sucesso!"
    rescue ActiveRecord::RecordNotDestroyed => e
      redirect_to pending_approvals_path, alert: "Erro ao recusar cadastro: #{e.message}"
  end

  # Aprova o usuário (atualiza o papel do usuário).
  #
  # @return [void] Redireciona para a página de aprovação com uma mensagem de sucesso ou erro.
  def approve_user
    if @user.update(user_params)
      redirect_pending_approvals(notice: "Cadastro aprovado com sucesso!")
    else
      redirect_pending_approvals(alert: "Erro ao aprovar cadastro: #{@user.errors.full_messages.join(', ')}")
    end
  end

  private

  # Define o usuário com base no ID fornecido.
  #
  # @return [void] Define a variável de instância `@user` para o usuário correspondente ao ID.
  def set_user
    @user = User.find(params[:id])
  end

  # Valida o cargo do usuário para garantir que seja um valor válido.
  #
  # @return [void] Redireciona para a página de aprovações com um alerta caso o cargo seja inválido.
  def validate_role
    return if valid_role?(user_params[:role])

    redirect_pending_approvals(alert: "Cargo inválido.")
  end

  # Verifica se o usuário tem permissão para aprovar o cadastro de outro usuário com base no cargo.
  #
  # @return [void] Redireciona para a página de aprovações com um alerta caso o usuário não tenha permissão.
  def authorize_approval
    return if authorized_to_approve?(user_params[:role])

    redirect_pending_approvals(alert: "Você não tem permissão para realizar esta ação.")
  end

  # Redireciona o usuário para a página de aprovação com a mensagem flash fornecida.
  #
  # @param flash_options [Hash] Opções para a mensagem flash, como `:notice` ou `:alert`.
  # @return [void] Redireciona para a página `pending_approvals_path` com a mensagem flash fornecida.
  def redirect_pending_approvals(flash_options)
    redirect_to pending_approvals_path, flash_options
  end

  # Permite apenas o parâmetro `:role` ser passado para o método de atualização do usuário.
  #
  # @return [ActionController::Parameters] Permite o parâmetro `:role`.
  def user_params
    params.permit(:role)
  end

  # Verifica se o cargo fornecido é um dos valores válidos: "discente", "docente" ou "administrador".
  #
  # @param role [String] O cargo do usuário a ser validado.
  # @return [Boolean] Retorna `true` se o cargo for válido, caso contrário `false`.
  def valid_role?(role)
    ["discente", "docente", "administrador"].include?(role)
  end

  # Verifica se o usuário tem permissão para aprovar o cadastro com base no cargo.
  #
  # @param new_role [String] O novo cargo do usuário a ser aprovado.
  # @return [Boolean] Retorna `true` se o usuário tem permissão para aprovar, caso contrário `false`.
  def authorized_to_approve?(new_role)
    current_user.role == "administrador" || (current_user.role == "docente" && new_role != "administrador")
  end

  # Restringe o acesso à página de aprovações para usuários que não sejam administradores ou docentes.
  #
  # @return [void] Redireciona o usuário para a página inicial com uma mensagem de "Acesso negado" 
  # caso ele não tenha permissão.
  def authorize_admin_or_docente
    unless current_user && current_user.role.in?(["administrador", "docente"])
      redirect_to root_path, alert: "Acesso negado."
    end
  end
end