class CreateChannelurls < ActiveRecord::Migration
  def change
    create_table :channelurls do |t|
      t.string :url

      t.timestamps
    end
  end
end
