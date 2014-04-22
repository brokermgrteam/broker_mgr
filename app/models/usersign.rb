# encoding: utf-8
class Usersign < ActiveRecord::Base
  attr_accessible :sign_date, :sign_type, :user_id

  belongs_to	:user
end
# == Schema Information
#
# Table name: usersigns
#
#  id         :integer(38)     not null, primary key
#  user_id    :integer(38)
#  sign_date  :datetime
#  sign_type  :integer(38)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

