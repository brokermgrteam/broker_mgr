# encoding: utf-8
class Salary < ActiveRecord::Base
  attr_accessible :broker_id, :indextype, :month_id, :occursum, :remark
  
  belongs_to :broker
  
  # default_scope :order => 'salaries.month_id DESC'
  
end
# == Schema Information
#
# Table name: salaries
#
#  id         :integer(38)     not null, primary key
#  month_id   :integer(38)
#  indextype  :integer(38)
#  broker_id  :integer(38)
#  occursum   :decimal(, )
#  remark     :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

