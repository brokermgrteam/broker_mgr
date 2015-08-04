class CreateRecurrings < ActiveRecord::Migration
  def change
    create_table :recurrings do |t|

      t.timestamps
    end
  end
end
