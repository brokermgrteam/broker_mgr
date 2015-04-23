class CreateWorkflowsteps < ActiveRecord::Migration
  def change
    create_table :workflowsteps do |t|
      t.integer :step
      t.integer :workflow_id
      t.integer :userposition_id
      t.string :memo

      t.timestamps
    end
    add_index(:workflowsteps :workflow_id)
  end
end
