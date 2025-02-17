class AddDetailsToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :course, :string
    add_column :users, :matricula, :string
    add_column :users, :usuario, :string
    add_column :users, :formacao, :string
  end
end
