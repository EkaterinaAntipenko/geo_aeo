class CreateWorkspaces < ActiveRecord::Migration[8.1]
  def change
    create_table :workspaces do |t|
      t.string :name
      t.string :legal_name
      t.string :industry
      t.string :region
      t.references :owner, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
