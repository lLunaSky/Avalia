class Avaliacao < ApplicationRecord
  self.table_name = "avaliacoes"
  has_many :respostas, dependent: :destroy
end
