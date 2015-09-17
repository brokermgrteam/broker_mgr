class CreateMassages < ActiveRecord::Migration
  def change
    create_table :massages do |t|
      t.string :title
      t.text :content
      t.integer :user_id
      t.integer :messenger_id
      t.string :file

      t.timestamps
    end
    add_index(:massages, :user_id)
  end
end
