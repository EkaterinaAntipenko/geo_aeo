class CreateMemberships < ActiveRecord::Migration[8.1]
  def change
    create_table :memberships do |t|
      t.references :user, null: false, foreign_key: true
      t.references :workspace, null: false, foreign_key: true
      t.string :role
      t.integer :invited_by
      t.datetime :joined_at

      t.timestamps
    end
    add_index :memberships, :invited_by
    add_foreign_key :memberships, :users, column: :invited_by
  end
end
