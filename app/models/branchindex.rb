# == Schema Information
#
# Table name: branchindices
#
#  id         :integer(38)     not null primary key
#  branch_id  :integer(38)
#  month_id   :string(255)
#  indextype  :integer(38)
#  occursum   :decimal( )
#  remark     :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Branchindex < ActiveRecord::Base
  belongs_to :department
  
  default_scope   :order => 'branchindices.month_id'
end
