class CreateSystemtasklogs < ActiveRecord::Migration
  def change
    create_table :systemtasklogs do |t|
      t.date :task_date
      t.integer :total_tasks
      t.integer :complete_tasks
      t.integer :task_type
      t.string :description

      t.timestamps
    end
  end
end
