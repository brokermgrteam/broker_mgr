class Brokercoursereport < ActiveRecord::Base
  attr_accessible :course_code, :course_finish_time, :course_name, :course_period, :course_score, :employee_code, :plan_start_time, :step_to_get_score, :user_name
end
# == Schema Information
#
# Table name: brokercoursereports
#
#  id                 :integer(38)     not null, primary key
#  course_code        :string(255)
#  course_finish_time :datetime
#  course_name        :string(255)
#  course_period      :decimal(, )
#  course_score       :decimal(, )
#  employee_code      :string(255)
#  plan_start_time    :datetime
#  step_to_get_score  :string(255)
#  user_name          :string(255)
#  created_at         :datetime        not null
#  updated_at         :datetime        not null
#

