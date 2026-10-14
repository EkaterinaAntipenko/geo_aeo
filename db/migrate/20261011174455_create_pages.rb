class CreatePages < ActiveRecord::Migration[8.1]
  def change
    create_table :pages do |t|
      t.references :site, null: false, foreign_key: true
      t.string :url
      t.string :title
      t.string :page_type
      t.boolean :has_schema
      t.float :score
      t.datetime :last_crawled_at

      t.timestamps
    end
  end
end
