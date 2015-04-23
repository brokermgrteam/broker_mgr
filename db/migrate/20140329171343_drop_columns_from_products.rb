class DropColumnsFromProducts < ActiveRecord::Migration
  def up
  	remove_column :products :f1
  	remove_column :products :f2
  	remove_column :products :f3

  	remove_column :products :f1_name
  	remove_column :products :f2_name
  	remove_column :products :f3_name
  end

  def down
  end
end
