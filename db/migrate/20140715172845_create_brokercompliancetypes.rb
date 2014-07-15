class CreateBrokercompliancetypes < ActiveRecord::Migration
  def change
    create_table :brokercompliancetypes do |t|
      t.integer :compliance_code
      t.string :compliance_type
      t.string :compliance_type_detail

      t.timestamps
    end
  end
end
