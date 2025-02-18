class CreateResposta < ActiveRecord::Migration[8.0]
  def change
    create_table :resposta do |t|
      t.references :avaliacao, null: false, foreign_key: true
      t.string :pergunta
      t.string :resposta
      t.string :usuario

      t.timestamps
    end
  end
end
