class AddFlowidToFlowpositionrels < ActiveRecord::Migration
  def change
    add_column :flowpositionrels, :flowid, :integer
  end
end
