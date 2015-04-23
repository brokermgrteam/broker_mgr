class AddBirthdayToCusts < ActiveRecord::Migration
  def change
    add_column :custs, :birthday, :date
  end
end
