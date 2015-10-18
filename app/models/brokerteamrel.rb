# encoding: utf-8
class Brokerteamrel < ActiveRecord::Base
  attr_accessible :broker_id, :lower_broker_id

  belongs_to :broker,     :class_name => "Broker"
  belongs_to :teambroker, :class_name => "Broker"
end
# == Schema Information
#
# Table name: brokerteamrels
#
#  id              :integer(38)     not null, primary key
#  broker_id       :integer(38)
#  lower_broker_id :integer(38)
#  created_at      :datetime        not null
#  updated_at      :datetime        not null
#
