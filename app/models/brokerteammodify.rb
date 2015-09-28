# encoding: utf-8
class Brokerteammodify < ActiveRecord::Base
  attr_accessible :broker_id, :memo, :modify_type, :status, :user_id, :workflowunderway_id,
                  :massage_id

  belongs_to :workflowunderway
  belongs_to :workflowhistory
  belongs_to :massage
end
# == Schema Information
#
# Table name: brokerteammodifies
#
#  id                  :integer(38)     not null, primary key
#  broker_id           :integer(38)
#  modify_type         :integer(38)
#  status              :integer(38)
#  user_id             :integer(38)
#  memo                :string(255)
#  workflowunderway_id :integer(38)
#  created_at          :datetime        not null
#  updated_at          :datetime        not null
#
