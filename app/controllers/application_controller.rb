# Controlador base da aplicação. Este controlador é responsável por garantir que 
# o usuário esteja autenticado antes de acessar qualquer ação que requeira login.
class ApplicationController < ActionController::Base

  # Chama o método `authenticate_user!` antes de cada ação para garantir que o usuário esteja logado.
  # A partir disso, o método `current_user` é utilizado para recuperar o usuário autenticado.
  before_action :authenticate_user!

  # Torna o método `current_user` disponível para as views como um helper.
  helper_method :current_user

  private

  # Garante que o usuário esteja autenticado.
  #
  # Se o usuário não estiver autenticado (se `current_user` for `nil`), 
  # redireciona o usuário para a página inicial (root_path) com uma mensagem de alerta.
  # @return [void] Não retorna valor. Apenas redireciona o usuário em caso de falha.
  def authenticate_user!
    unless current_user
      redirect_to root_path, alert: "Você precisa estar logado."
    end
  end

  # Retorna o usuário atualmente autenticado.
  #
  # O método recupera o usuário armazenado na sessão. O usuário é buscado 
  # pelo endereço de e-mail na sessão.
  #
  # @return [User, nil] Retorna o objeto `User` correspondente ao e-mail armazenado 
  # na sessão, ou `nil` se o usuário não for encontrado.
  # @note Este método utiliza a variável de instância `@current_user` para 
  # evitar múltiplas consultas ao banco de dados durante uma única requisição.
  def current_user
    @current_user ||= User.find_by(email: session[:user_email])
  end
  
end