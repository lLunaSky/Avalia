 # features/support/env.rb

# Configurações globais para os testes
require 'capybara/cucumber'
require 'capybara/rails'
require 'factory_bot'

Capybara.default_driver = :selenium

# Definindo variáveis globais
$usuario_admin = "admin"
$senha_admin = "senha123"

# Hooks
Before do
  # Limpar o banco de dados antes de cada cenário, se necessário
  # User.delete_all
  puts "Iniciando o cenário de teste..."
end

After do
  # Limpeza pós-teste ou outras ações
  puts "Cenário finalizado."
end

# Conectar com o banco de dados, se necessário
# ActiveRecord::Base.establish_connection
