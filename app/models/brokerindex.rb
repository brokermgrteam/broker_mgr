class Brokerindex < ActiveRecord::Base
  belongs_to :broker
  
  default_scope :order => 'brokerindices.month_id'
  
end
# == Schema Information
#
# Table name: brokerindices
#
#  id         :integer(38)     not null primary key
#  broker_id  :integer(38)
#  month_id   :string(255)
#  indextype  :integer(38)
#  occursum   :decimal( )
#  remark     :string(255)
#  created_at :datetime
#  updated_at :datetime
#

