class CreateSalaries < ActiveRecord::Migration
  def change
    create_table :salaries do |t|
      t.integer :month_id
      t.integer :indextype
      t.integer :broker_id
      t.float :occursum
      t.string :remark

      t.timestamps
    end
    add_index(:salaries, [:broker_id, :month_id, :indextype])
  end
end
