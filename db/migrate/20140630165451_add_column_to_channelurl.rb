class AddColumnToChannelurl < ActiveRecord::Migration
  def change
    add_column :channelurls :channel_id :integer
    add_column :channelurls :branch_id :integer
    add_column :channelurls :serv_branch_id :integer
    add_column :channelurls :broker_id :integer
  end
end
