class CreateProductattachments < ActiveRecord::Migration
  def change
    create_table :productattachments do |t|
      t.integer :product_id
      t.string :file_name
      t.string :file_type
      t.binary :file_binary
      t.integer :order

      t.timestamps
    end
    add_index  :productattachments, :product_id
  end
end
