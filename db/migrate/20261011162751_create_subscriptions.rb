class CreateSubscriptions < ActiveRecord::Migration[8.1]
  def change
    create_table :subscriptions do |t|
      t.references :workspace, null: false, foreign_key: true
      t.references :plan, null: false, foreign_key: true
      t.string :status
      t.datetime :started_at
      t.datetime :renews_at
      t.date :trial_ends_at

      t.timestamps
    end
  end
end
