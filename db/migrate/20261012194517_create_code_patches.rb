class CreateCodePatches < ActiveRecord::Migration[8.1]
  def change
    create_table :code_patches do |t|
      t.references :recommendation, null: false, foreign_key: true
      t.string :target
      t.string :language
      t.text :code
      t.string :file_path
      t.boolean :applied
      t.datetime :verified_at

      t.timestamps
    end
  end
end
