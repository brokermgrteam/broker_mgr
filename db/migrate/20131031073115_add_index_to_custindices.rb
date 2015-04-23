class AddIndexToCustindices < ActiveRecord::Migration
  def change
    add_index :custindices, :cust_id
  end
end
