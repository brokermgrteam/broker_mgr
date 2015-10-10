class AddFailedTimesToUsers < ActiveRecord::Migration
  def change
    add_column :users, :failed_times, :integer
  end
end
