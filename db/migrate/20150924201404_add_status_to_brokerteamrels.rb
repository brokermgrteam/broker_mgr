class AddStatusToBrokerteamrels < ActiveRecord::Migration
  def change
    add_column :brokerteamrels, :status, :integer
  end
end
