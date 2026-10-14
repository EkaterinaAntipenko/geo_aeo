class CreatePlans < ActiveRecord::Migration[8.1]
  def change
    create_table :plans do |t|
      t.string :name
      t.string :site_type
      t.integer :price_month
      t.integer :pages_limit
      t.integer :domains_limit
      t.integer :queries_limit
      t.json :features

      t.timestamps
    end
  end
end
