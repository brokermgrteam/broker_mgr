class CreateBrokercompliancelogs < ActiveRecord::Migration
  def change
    create_table :brokercompliancelogs do |t|
      t.integer :broker_id
      t.integer :compliance_type
      t.integer :occur_sum
      t.date :occur_date
      t.integer :user_id

      t.timestamps
    end
    add_index(:brokercompliancelogs :broker_id)
  end
end
