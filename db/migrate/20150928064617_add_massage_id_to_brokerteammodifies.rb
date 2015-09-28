class AddMassageIdToBrokerteammodifies < ActiveRecord::Migration
  def change
    remove_column :brokerteammodifies, :notice_id
    add_column :brokerteammodifies, :massage_id, :integer
  end
end
