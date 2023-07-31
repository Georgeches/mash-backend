class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
       t.string :customer_name
      t.string :products_ordered
      t.date :date
      t.belongs_to :merchandiser, null: false, foreign_key: true

      t.timestamps
    end
  end
end
