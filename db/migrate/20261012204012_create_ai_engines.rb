class CreateAiEngines < ActiveRecord::Migration[8.1]
  def change
    create_table :ai_engines do |t|
      t.string :name
      t.string :type
      t.string :region
      t.boolean :is_active

      t.timestamps
    end
  end
end
