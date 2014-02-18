class CreateInstitutions < ActiveRecord::Migration
  def change
    create_table :institutions do |t|
      t.string :institution_code
      t.string :institution_name

      t.timestamps
    end
  end
end
