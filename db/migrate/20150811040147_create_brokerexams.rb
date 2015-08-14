class CreateBrokerexams < ActiveRecord::Migration
  def change
    create_table :brokerexams do |t|
      t.string :employeeCode
      t.integer :endTime
      t.string :examCode
      t.integer :examCount
      t.string :examName
      t.float :examScore
      t.float :firstExamScore
      t.string :judgeFlag
      t.string :pass
      t.integer :startTime
      t.string :userName

      t.timestamps
    end
  end
end
