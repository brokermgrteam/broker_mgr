class Workflowexe < ActiveRecord::Base
  attr_accessible :content, :workflow_id, :remark, :step, :user_id, :custservvisit_attributes
  
  has_one :custservvisit
  
  accepts_nested_attributes_for :custservvisit
end
# == Schema Information
#
# Table name: workflowexes
#
#  id          :integer(38)     not null, primary key
#  step        :integer(38)
#  content     :string(255)
#  remark      :string(255)
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#  workflow_id :integer(38)
#  user_id     :integer(38)
#

