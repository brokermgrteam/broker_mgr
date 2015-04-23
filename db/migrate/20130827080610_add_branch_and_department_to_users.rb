class AddBranchAndDepartmentToUsers < ActiveRecord::Migration
  def change
    add_column :users :branch_id :integer
    add_column :users :department_id :integer
  end
end
