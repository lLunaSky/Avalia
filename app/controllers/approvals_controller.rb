class ApprovalsController < ApplicationController
    before_action :authenticate_user!
    before_action :authorize_admin_or_docente, only: [:index, :approve_user, :reject_user]
    before_action :set_user, only: [:approve_user, :reject_user]
  
    def index
      @pending_users = User.where(role: nil)
      render 'pending_approvals'
    end
  
    def reject_user
      @user.destroy!
      redirect_to pending_approvals_path, notice: "Cadastro recusado com sucesso!"
      rescue ActiveRecord::RecordNotDestroyed => e
        redirect_to pending_approvals_path, alert: "Erro ao recusar cadastro: #{e.message}"
    end

    def approve_user
      if @user.update(user_params)
        redirect_pending_approvals(notice: "Cadastro aprovado com sucesso!")
      else
        redirect_pending_approvals(alert: "Erro ao aprovar cadastro: #{@user.errors.full_messages.join(', ')}")
      end
    end
  
    private

    def set_user
      @user = User.find(params[:id])
    end
  
    def validate_role
      return if valid_role?(user_params[:role])
  
      redirect_pending_approvals(alert: "Cargo inválido.")
    end
  
    def authorize_approval
      return if authorized_to_approve?(user_params[:role])
  
      redirect_pending_approvals(alert: "Você não tem permissão para realizar esta ação.")
    end
  
    def redirect_pending_approvals(flash_options)
      redirect_to pending_approvals_path, flash_options
    end
  
    def user_params
      params.permit(:role)
    end

    def valid_role?(role)
      ["discente", "docente", "administrador"].include?(role)
    end

    def authorized_to_approve?(new_role)
      current_user.role == "administrador" || (current_user.role == "docente" && new_role != "administrador")
    end
  
    def authorize_admin_or_docente
      unless current_user && current_user.role.in?(["administrador", "docente"])
        redirect_to root_path, alert: "Acesso negado."
      end
    end
  end
  