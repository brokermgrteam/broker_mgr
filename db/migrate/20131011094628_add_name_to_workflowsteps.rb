class AddNameToWorkflowsteps < ActiveRecord::Migration
  def change
    add_column :workflowsteps :name :string
  end
end
