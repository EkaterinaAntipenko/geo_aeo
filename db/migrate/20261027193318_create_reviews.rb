class CreateReviews < ActiveRecord::Migration[8.1]
  def change
    create_table :reviews do |t|
      t.string :company
      t.string :author
      t.string :position
      t.text :text
      t.float :geo_rate
      t.float :aeo_rate
      t.string :avatar

      t.timestamps
    end
  end
end
