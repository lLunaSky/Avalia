class CreateRespostas < ActiveRecord::Migration[8.0]
  def change
    create_table :respostas do |t|  # <-- Corrigido para plural
      t.references :avaliacao, null: false, foreign_key: true
      t.string :pergunta
      t.string :resposta
      t.string :usuario

      t.timestamps
    end
  end
end
