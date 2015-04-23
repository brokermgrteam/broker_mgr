class CreateCusts < ActiveRecord::Migration
  def change
    create_table :custs do |t|
      t.string :capital_account, :limit => 10
      t.string :cust_name
      t.integer :identification_type
      t.string :identification_number
      t.string :address
      t.string :phone
      t.string :mobile
      t.string :zip_code
      t.integer :branch_id
      t.integer :status
      t.integer :capital_account_type
      t.string :open_date, :limit => 8
      t.string :close_date, :limit => 8
      t.string :valid_date, :limit => 8
      t.string :assessment_date, :limit => 8
      t.string :valid_date_crop, :limit => 8

      t.timestamps
    end
    add_index :custs, :capital_account, :unique => true
    add_index :custs, :open_date 
  end
end
