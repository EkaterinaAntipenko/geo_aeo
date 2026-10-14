class CreateAudits < ActiveRecord::Migration[8.1]
  def change
    create_table :audits do |t|
      t.references :site, null: false, foreign_key: true
      t.string :kind
      t.string :trigger
      t.string :status
      t.float :total_score
      t.datetime :started_at
      t.datetime :finished_at

      t.timestamps
    end
  end
end
