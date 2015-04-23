# encoding: utf-8
class Brokerrel < ActiveRecord::Base
  belongs_to :broker,    :class_name => "Broker"
  belongs_to :relbroker, :class_name => "Broker"
  
  validates :broker_id,     :presence => true
  validates :rel_broker_id, :presence => true
end

# == Schema Information
#
# Table name: brokerrels
#
#  id            :integer(38)     not null, primary key
#  broker_id     :integer(38)
#  rel_broker_id :integer(38)
#  created_at    :datetime
#  updated_at    :datetime
#

