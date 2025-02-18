class CreateRespostas < ActiveRecord::Migration[8.0]
  def change
    create_table :respostas do |t|
      t.references :avaliacao, null: false, foreign_key: true
      t.string :pergunta, null: false
      t.string :resposta, null: false
      t.string :usuario, null: false

      t.timestamps
    end
  end
end
