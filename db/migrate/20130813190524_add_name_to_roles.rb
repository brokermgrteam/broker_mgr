class AddNameToRoles < ActiveRecord::Migration
  def change
    remove_column :roles :role_name
    add_column :roles :name :string
  end
end
