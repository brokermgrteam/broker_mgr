class AddUsercodeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :usercode, :string
  end
end
