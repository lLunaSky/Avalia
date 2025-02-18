class Avaliacao < ApplicationRecord
  self.table_name = "avaliacoes" # Garante que Rails reconheça a tabela certa
  has_many :respostas
end
