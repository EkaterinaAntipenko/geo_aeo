class AddBoardFieldsToTasks < ActiveRecord::Migration[8.1]
  def change
    add_column :tasks, :title, :string
    add_column :tasks, :priority, :integer, default: 2
    add_reference :tasks, :site, foreign_key: true
    change_column_null :tasks, :recommendation_id, true
  end
end
