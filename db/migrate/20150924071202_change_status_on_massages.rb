class ChangeStatusOnMassages < ActiveRecord::Migration
  def up
    remove_column :massages, :status
    add_column :massages, :status, :boolean
  end

  def down
  end
end
