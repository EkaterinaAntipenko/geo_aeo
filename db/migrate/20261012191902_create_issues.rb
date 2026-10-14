class CreateIssues < ActiveRecord::Migration[8.1]
  def change
    create_table :issues do |t|
      t.references :audit, null: false, foreign_key: true
      t.references :page, null: true, foreign_key: true
      t.string :category
      t.string :severity
      t.string :title
      t.text :description
      t.string :status
      t.datetime :first_seen_at

      t.timestamps
    end
  end
end
