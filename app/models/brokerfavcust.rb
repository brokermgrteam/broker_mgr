class Brokerfavcust < ActiveRecord::Base
  attr_accessible :broker_id, :cust_id

  belongs_to :broker
  belongs_to :cust
end
# == Schema Information
#
# Table name: brokerfavcusts
#
#  id         :integer(38)     not null, primary key
#  broker_id  :integer(38)
#  cust_id    :integer(38)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

