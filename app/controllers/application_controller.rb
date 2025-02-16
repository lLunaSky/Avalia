# app/controllers/application_controller.rb
class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  helper_method :current_user

  private

  def authenticate_user!
    unless current_user
      redirect_to root_path, alert: "Você precisa estar logado."
    end
  end

  def current_user
    @current_user ||= User.find_by(email: session[:user_email])
  end
end