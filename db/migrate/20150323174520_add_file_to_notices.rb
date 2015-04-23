class AddFileToNotices < ActiveRecord::Migration
  def change
    add_column :notices, :file, :string
  end
end
