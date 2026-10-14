class CreateRecommendations < ActiveRecord::Migration[8.1]
  def change
    create_table :recommendations do |t|
      t.references :issue, null: false, foreign_key: true
      t.string :title
      t.text :explanation
      t.string :expected_impact
      t.string :effort
      t.integer :priority
      t.string :status

      t.timestamps
    end
  end
end
