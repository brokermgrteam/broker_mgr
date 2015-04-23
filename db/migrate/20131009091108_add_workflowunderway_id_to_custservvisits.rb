class AddWorkflowunderwayIdToCustservvisits < ActiveRecord::Migration
  def change
    add_column :custservvisits, :workflowunderway_id, :integer
  end
end
