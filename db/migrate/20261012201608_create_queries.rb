class CreateQueries < ActiveRecord::Migration[8.1]
  def change
    create_table :queries do |t|
      t.references :site, null: false, foreign_key: true
      t.string :text
      t.string :intent
      t.string :region
      t.boolean :is_tracked

      t.timestamps
    end
  end
end
