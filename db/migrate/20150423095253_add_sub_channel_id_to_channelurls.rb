class AddSubChannelIdToChannelurls < ActiveRecord::Migration
  def change
    add_column :channelurls :sub_channel_id :integer
  end
end
