# encoding: utf-8
class Workflowunderway < ActiveRecord::Base
  attr_accessible :content, :workflow_id, :remark, :step, :user_id, :custservvisit_attributes,
                  :brokerteammodify_attributes

  belongs_to :workflow
  has_one :custservvisit
  has_one :brokerteammodify

  accepts_nested_attributes_for :custservvisit
  accepts_nested_attributes_for :brokerteammodify
end
# == Schema Information
#
# Table name: workflowunderways
#
#  id          :integer(38)     not null, primary key
#  user_id     :integer(38)
#  workflow_id :integer(38)
#  step        :integer(38)
#  content     :string(255)
#  remark      :string(255)
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#
# == Schema Information
#
# Table name: workflowunderways
#
#  id          :integer(38)     not null, primary key
#  user_id     :integer(38)
#  workflow_id :integer(38)
#  step        :integer(38)
#  content     :string(255)
#  remark      :string(255)
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#

