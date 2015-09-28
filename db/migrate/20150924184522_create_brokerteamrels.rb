class CreateBrokerteamrels < ActiveRecord::Migration
  def change
    create_table :brokerteamrels do |t|
      t.integer :broker_id
      t.integer :lower_broker_id

      t.timestamps
    end
  end
end
