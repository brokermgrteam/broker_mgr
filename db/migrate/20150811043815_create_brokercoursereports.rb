class CreateBrokercoursereports < ActiveRecord::Migration
  def change
    create_table :brokercoursereports do |t|
      t.string :course_code
      t.date :course_finish_time
      t.string :course_name
      t.float :course_period
      t.float :course_score
      t.string :employee_code
      t.date :plan_start_time
      t.string :step_to_get_score
      t.string :user_name

      t.timestamps
    end
  end
end
