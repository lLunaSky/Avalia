class Resposta < ApplicationRecord
  self.table_name = "respostas" # Garante que o Rails use a tabela correta
  belongs_to :avaliacao
end
