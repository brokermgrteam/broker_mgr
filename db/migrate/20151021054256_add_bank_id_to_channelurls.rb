class AddBankIdToChannelurls < ActiveRecord::Migration
  def change
    add_column :channelurls, :bank_id, :integer
  end
end
