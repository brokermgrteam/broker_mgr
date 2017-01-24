class Custbrokerrel < ActiveRecord::Base
  set_primary_key 'id'
  attr_accessible :dis_ratio
  attr_accessible :rel_status, :broker_id, :cust_id, :dis_ratio, :rel_date

  belongs_to :broker
  belongs_to :cust
end
# == Schema Information
#
# Table name: custbrokerrels
#
#  id         :integer(38)     not null, primary key
#  broker_id  :integer(38)
#  cust_id    :integer(38)
#  rel_status :integer(38)
#  rel_date   :string(8)
#  dis_ratio  :decimal(, )
#  created_at :datetime        not null
#  updated_at :datetime        not null
#
