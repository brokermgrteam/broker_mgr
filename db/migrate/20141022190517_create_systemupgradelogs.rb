class CreateSystemupgradelogs < ActiveRecord::Migration
  def change
    create_table :systemupgradelogs do |t|
      t.date :update_date
      t.string :description

      t.timestamps
    end
  end
end
