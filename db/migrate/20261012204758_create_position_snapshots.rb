class CreatePositionSnapshots < ActiveRecord::Migration[8.1]
  def change
    create_table :position_snapshots do |t|
      t.references :query, null: false, foreign_key: true
      t.references :engine, null: false, foreign_key: { to_table: :ai_engines }
      t.references :competitor, null: true, foreign_key: true
      t.date :checked_at
      t.integer :position
      t.boolean :is_mentioned
      t.boolean :is_cited
      t.string :cited_url
      t.string :sentiment
      t.float :share_of_voice

      t.timestamps
    end
  end
end
