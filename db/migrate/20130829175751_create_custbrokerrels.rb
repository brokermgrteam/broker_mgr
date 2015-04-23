class CreateCustbrokerrels < ActiveRecord::Migration
  def change
    create_table :custbrokerrels do |t|
      t.integer :broker_id
      t.integer :cust_id
      t.integer :rel_status
      t.string :rel_date :limit => 8
      t.float :dis_ratio

      t.timestamps
    end
    add_index(:custbrokerrels :broker_id)  
    add_index(:custbrokerrels :cust_id)  
  end
end
