class CreateSubchannels < ActiveRecord::Migration
  def change
    create_table :subchannels do |t|
      t.integer :channel_id
      t.string :sub_channel_code
      t.string :sub_channel_name
      t.string :sub_channel_broker
      t.boolean :status

      t.timestamps
    end
  end
end
