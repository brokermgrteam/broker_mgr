class Assignment < ActiveRecord::Base
  attr_accessible :role_id :user_id
  
  belongs_to :user
  belongs_to :role
end
# == Schema Information
#
# Table name: assignments
#
#  id         :integer(38)     not null primary key
#  user_id    :integer(38)
#  role_id    :integer(38)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

