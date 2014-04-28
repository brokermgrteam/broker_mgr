class Custbrokerproductrel < ActiveRecord::Base
  attr_accessible :rel_status

  belongs_to :broker
  belongs_to :cust
end
# == Schema Information
#
# Table name: custbrokerproductrels
#
#  id         :integer(38)     not null, primary key
#  broker_id  :integer(38)
#  cust_id    :integer(38)
#  product_id :integer(38)
#  rel_status :integer(38)
#  rel_date   :string(8)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

