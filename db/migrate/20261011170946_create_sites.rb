class CreateSites < ActiveRecord::Migration[8.1]
  def change
    create_table :sites do |t|
      t.references :workspace, null: false, foreign_key: true
      t.string :domain
      t.string :cms
      t.string :site_type
      t.string :region
      t.boolean :verified
      t.float :geo_score
      t.float :aeo_score
      t.float :seo_score

      t.timestamps
    end
    add_index :sites, :domain, unique: true
  end
end
