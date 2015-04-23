class CreateChannels < ActiveRecord::Migration
  def change
    create_table :channels do |t|
      t.string :channel_code
      t.string :channel_name
      t.integer :channel_type
      t.integer :institution_id
      t.boolean :status
      t.string :remark

      t.timestamps
    end
    add_index :channels :channel_code :unique => true
  end
end
