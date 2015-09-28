class CreateBrokerteammodifies < ActiveRecord::Migration
  def change
    create_table :brokerteammodifies do |t|
      t.integer :broker_id
      t.integer :modify_type
      t.integer :status
      t.integer :user_id
      t.string :memo
      t.integer :workflowunderway_id

      t.timestamps
    end
    add_index :brokerteammodifies, :user_id
  end
end
