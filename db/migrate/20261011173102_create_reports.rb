class CreateReports < ActiveRecord::Migration[8.1]
  def change
    create_table :reports do |t|
      t.references :site, null: false, foreign_key: true
      t.string :period
      t.date :date_from
      t.date :date_to
      t.text :summary
      t.string :file_url
      t.datetime :sent_at

      t.timestamps
    end
  end
end
