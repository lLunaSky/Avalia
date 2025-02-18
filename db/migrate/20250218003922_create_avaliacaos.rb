class CreateAvaliacaos < ActiveRecord::Migration[8.0]
  def change
    create_table :avaliacaos do |t|
      t.string :nome
      t.string :semestre
      t.string :codigo

      t.timestamps
    end
  end
end
