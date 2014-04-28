class CreateCustbrokerproductrels < ActiveRecord::Migration
  def change
    create_table :custbrokerproductrels do |t|
      t.integer :broker_id
      t.integer :cust_id
      t.integer :product_id
      t.integer :rel_status
      t.string :rel_date, :limit => 8

      t.timestamps
    end
    add_index(:custbrokerproductrels, :broker_id)  
    add_index(:custbrokerproductrels, :cust_id)  
  end
end
