class CreateReadnotices < ActiveRecord::Migration
  def change
    create_table :readnotices do |t|
      t.integer :notice_id
      t.integer :user_id

      t.timestamps
    end
  end
end
