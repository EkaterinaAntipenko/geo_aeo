class CreateTasks < ActiveRecord::Migration[8.1]
  def change
    create_table :tasks do |t|
      t.references :recommendation, null: false, foreign_key: true
      t.references :assignee, null: true, foreign_key: { to_table: :users }
      t.integer :created_by, null: false
      t.string :status
      t.date :due_date
      t.string :external_url

      t.timestamps
    end
    add_index :tasks, :created_by
    add_foreign_key :tasks, :users, column: :created_by
  end
end
