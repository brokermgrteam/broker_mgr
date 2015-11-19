class CreateBrokertraininglogs < ActiveRecord::Migration
  def change
    create_table :brokertraininglogs do |t|
      t.string :exammark
      t.string :examname
      t.string :idcard
      t.string :ispass
      t.string :passtime
      t.string :usercode
      t.string :collectdate

      t.timestamps
    end
  end
end
