class CreateBanks < ActiveRecord::Migration
  def change
    create_table :banks do |t|
      t.string :bank_code
      t.string :bank_name
      t.boolean :status

      t.timestamps
    end
  end
end
