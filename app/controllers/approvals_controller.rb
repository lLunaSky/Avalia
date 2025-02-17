class ApprovalsController < ApplicationController
    before_action :authenticate_user!
    before_action :authorize_admin_or_docente, only: [:index, :approve_user, :reject_user]
  
    def index
      @pending_users = User.where(role: nil)
      render 'pending_approvals'
    end
  
    def approve_user
      user = User.find(params[:id])
      new_role = params[:role]
      
      unless ["discente", "docente", "administrador"].include?(new_role)
        redirect_to pending_approvals_path, alert: "Cargo inválido."
        return
      end
      
      if current_user.role == "administrador" || (current_user.role == "docente" && new_role != "administrador")
        if user.update(role: new_role)  # Aqui, atualiza o campo 'role' diretamente
          redirect_to pending_approvals_path, notice: "Cadastro aprovado com sucesso!"
        else
          redirect_to pending_approvals_path, alert: "Erro ao aprovar cadastro: #{user.errors.full_messages.join(', ')}"
        end
      else
        redirect_to pending_approvals_path, alert: "Você não tem permissão para realizar esta ação."
      end
    end
  
    def reject_user
      user = User.find(params[:id])
      user.destroy!
      redirect_to pending_approvals_path, notice: "Cadastro recusado com sucesso!"
    rescue ActiveRecord::RecordNotDestroyed => e
      redirect_to pending_approvals_path, alert: "Erro ao recusar cadastro: #{e.message}"
    end
  
    private
  
    def authorize_admin_or_docente
      unless current_user && current_user.role.in?(["administrador", "docente"])
        redirect_to root_path, alert: "Acesso negado."
      end
    end
  end
  