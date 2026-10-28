class CreateArticles < ActiveRecord::Migration[8.1]
  def change
    create_table :articles do |t|
      t.references :category, null: false, foreign_key: true
      t.string :title
      t.string :lead
      t.text :body
      t.string :image
      t.integer :read_time

      t.timestamps
    end
  end
end
