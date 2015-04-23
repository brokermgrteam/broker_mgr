class CreateBrokerfavcusts < ActiveRecord::Migration
  def change
    create_table :brokerfavcusts do |t|
      t.integer :broker_id
      t.integer :cust_id

      t.timestamps
    end
    add_index(:brokerfavcusts :broker_id)  
  end
end
