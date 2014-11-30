class CreateMonths < ActiveRecord::Migration
  def change
    create_table :months do |t|
      t.integer :year
      t.string :month

      t.timestamps
    end
    add_index(:months, :month, :unique => true)
  end
end
