class RemoveColumnWorkflowexeIdOnCustservvisits < ActiveRecord::Migration
  def up
    remove_column(:custservvisits, :workflowexe_id)
  end

  def down
  end
end
