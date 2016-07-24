class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.references :event
      t.references :user
      t.references :ticket_type
      t.integer :quantity

      t.timestamps null: false
    end
  end
end
