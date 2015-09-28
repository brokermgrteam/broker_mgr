class AddNoticeIdToBrokerteammodifies < ActiveRecord::Migration
  def change
    add_column :brokerteammodifies, :notice_id, :integer
  end
end
