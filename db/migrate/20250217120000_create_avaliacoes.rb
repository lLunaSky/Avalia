class CreateAvaliacoes < ActiveRecord::Migration[8.0]
  def change
    create_table :avaliacoes do |t|  # <-- Corrigido para plural
      t.string :nome
      t.string :semestre
      t.string :codigo

      t.timestamps
    end
  end
end
