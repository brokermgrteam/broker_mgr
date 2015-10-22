class AddCertificateNumToUsers < ActiveRecord::Migration
  def change
    add_column :users, :certificate_num, :string
    add_column :users, :mobile, :string
  end
end
