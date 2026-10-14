class CreateIntegrations < ActiveRecord::Migration[8.1]
  def change
    create_table :integrations do |t|
      t.references :site, null: false, foreign_key: true
      t.string :provider
      t.string :status
      t.string :token_ref
      t.datetime :connected_at

      t.timestamps
    end
  end
end
