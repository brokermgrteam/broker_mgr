class AddStatusToMassages < ActiveRecord::Migration
  def change
    add_column :massages, :status, :integer
  end
end
