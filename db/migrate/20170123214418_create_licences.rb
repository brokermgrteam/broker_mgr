class CreateLicences < ActiveRecord::Migration
  def change
    create_table :licences do |t|
      t.string :secure_hash
      t.string :expires_on

      t.timestamps
    end
  end
end
