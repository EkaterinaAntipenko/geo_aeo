class CreatePayments < ActiveRecord::Migration[8.1]
  def change
    create_table :payments do |t|
      t.references :subscription, null: false, foreign_key: true
      t.integer :amount
      t.string :currency
      t.string :status
      t.string :provider
      t.datetime :paid_at

      t.timestamps
    end
  end
end
