class AddFieldsToUsers < ActiveRecord::Migration[8.1]
  def change
    add_column :users, :name, :string
    add_column :users, :avatar, :string
    add_column :users, :role, :string
    add_column :users, :telegram_id, :string
  end
end
