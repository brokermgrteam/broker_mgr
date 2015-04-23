class AddIndexOnBranchIdToBrokers < ActiveRecord::Migration
  def change
    add_index :brokers, :branch_id
  end
end
