class AddServicesToCusts < ActiveRecord::Migration
  def change
    add_column :custs, :services, :string
  end
end
