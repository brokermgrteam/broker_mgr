class CreateDicts < ActiveRecord::Migration
  def change
    create_table :dicts do |t|
      t.string :name
      t.string :dict_type
      t.integer :code

      t.timestamps
    end
    add_index(:dicts, [:dict_type, :code], :unique => true)
  end
end
