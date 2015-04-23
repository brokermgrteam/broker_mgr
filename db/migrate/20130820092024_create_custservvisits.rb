class CreateCustservvisits < ActiveRecord::Migration
  def change
    create_table :custservvisits do |t|
      t.integer :workflowexe_id
      t.integer :cust_id
      t.string  :cust_name
      t.string  :plan_location
      t.datetime :plan_date
      t.datetime :visit_date
      t.string :visit_location
      t.string :attchment_file
      t.integer :user_id
      t.integer :assit_user_id
      t.integer :status
      t.string :visit_content
      t.string :memo

      t.timestamps
    end
    add_index(:custservvisits :workflowexe_id)
  end
end
