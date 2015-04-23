class AddWapurlToChannelurls < ActiveRecord::Migration
  def change
    add_column :channelurls, :wapurl, :string
  end
end
