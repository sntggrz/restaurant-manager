class CreateOrders < ActiveRecord::Migration[8.0]
  def change
    create_table :orders do |t|
      t.references :restaurant, null: false, foreign_key: true
      t.datetime :date
      t.decimal :subtotal
      t.decimal :taxes
      t.decimal :total

      t.timestamps
    end
  end
end
