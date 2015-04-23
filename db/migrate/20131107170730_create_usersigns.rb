class CreateUsersigns < ActiveRecord::Migration
  def change
    create_table :usersigns do |t|
      t.integer :user_id
      t.date :sign_date
      t.integer :sign_type

      t.timestamps
    end
    add_index(:usersigns, [:user_id, :sign_date])
  end
end
