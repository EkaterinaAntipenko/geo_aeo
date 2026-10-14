class CreateCompetitors < ActiveRecord::Migration[8.1]
  def change
    create_table :competitors do |t|
      t.references :site, null: false, foreign_key: true
      t.string :domain
      t.string :name
      t.integer :added_by, null: false

      t.timestamps
    end
    add_index :competitors, :added_by
    add_foreign_key :competitors, :users, column: :added_by
  end
end
