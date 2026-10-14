class CreateHealthChecks < ActiveRecord::Migration[8.1]
  def change
    create_table :health_checks do |t|
      t.references :site, null: false, foreign_key: true
      t.datetime :checked_at
      t.integer :http_status
      t.integer :response_ms
      t.float :uptime_pct
      t.integer :lcp_ms
      t.float :cls
      t.boolean :is_indexable

      t.timestamps
    end
  end
end
