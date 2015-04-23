class Passwordresetlog < ActiveRecord::Base
  attr_accessible :confirm_code :mobile :status :user_id
end
# == Schema Information
#
# Table name: passwordresetlogs
#
#  id           :integer(38)     not null primary key
#  user_id      :integer(38)
#  confirm_code :string(255)
#  mobile       :string(255)
#  status       :integer(38)
#  created_at   :datetime        not null
#  updated_at   :datetime        not null
#

