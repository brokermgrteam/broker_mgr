class Brokerexam < ActiveRecord::Base
  attr_accessible :employeeCode, :endTime, :examCode, :examCount, :examName, :examScore, :firstExamScore, :judgeFlag, :pass, :startTime, :userName
end
# == Schema Information
#
# Table name: brokerexams
#
#  id             :integer(38)     not null, primary key
#  employeeCode   :string(255)
#  endTime        :integer(38)
#  examCode       :string(255)
#  examCount      :integer(38)
#  examName       :string(255)
#  examScore      :decimal(, )
#  firstExamScore :decimal(, )
#  judgeFlag      :string(255)
#  pass           :string(255)
#  startTime      :integer(38)
#  userName       :string(255)
#  created_at     :datetime        not null
#  updated_at     :datetime        not null
#

